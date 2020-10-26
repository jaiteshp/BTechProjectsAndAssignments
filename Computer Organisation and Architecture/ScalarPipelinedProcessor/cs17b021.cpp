#include<bits/stdc++.h>
using namespace std;

int hexToIntChar(char c)
{
	switch(c)
	{
		case '0':	return 0;
		case '1':	return 1;
		case '2':	return 2;
		case '3':	return 3;
		case '4':	return 4;
		case '5':	return 5;
		case '6':	return 6;
		case '7':	return 7;
		case '8':	return 8;
		case '9':	return 9;
		case 'A':	return 10;
		case 'B':	return 11;
		case 'C':	return 12;
		case 'D':	return 13;
		case 'E':	return 14;
		case 'F':	return 15;
	}
}

char intToHexChar(int i)
{
	switch(i)
	{
		case 0:	return '0';
		case 1:	return '1';
		case 2:	return '2';
		case 3:	return '3';
		case 4:	return '4';
		case 5:	return '5';
		case 6:	return '6';
		case 7:	return '7';
		case 8:	return '8';
		case 9:	return '9';
		case 10:	return 'A';
		case 11:	return 'B';
		case 12:	return 'C';
		case 13:	return 'D';
		case 14:	return 'E';
		case 15:	return 'F';
	}
}

int hexToInt(string s)
{
	int val = 0;

	for(int i = 0; i <s.size(); i++)
	{
		val = val * 16 + hexToIntChar(s[i]);
	}

	return val;
}

class Processor
{
public:
	vector <string> I$_hex;		//Each instruction in hexadecimal
	vector <int> D$;
	vector <int> regs;
	vector <int> regOcc;	//register occupied [i] = 0 if ith register is unoccupied

	int pc = 0;						//Program counter
	int cycles = 0;
	vector <int> stalls;	//'1' if it is RAW hazard; '0' for control hazard
	vector <int> instructionsType;

	Processor()
	{
		ifstream read_I$;
		read_I$.open("ICache.txt");
		for(int i = 0; i < 128; i++)
		{
			string s;
			read_I$ >> s;

			I$_hex.push_back(s);
		}
		read_I$.close();

		ifstream read_D$;
		read_D$.open("DCache.txt");		
		for(int i = 0; i < 256; i++)
		{
			string s;
			read_D$ >> s;

			int val = hexToInt(s);

			if(val > 128)	val = val - 256;

			D$.push_back(val);
		}
		read_D$.close();

		ifstream read_regs;
		read_regs.open("RF.txt");
		for(int i = 0; i < 16; i++)
		{
			string s;
			read_regs >> s;

			int val = hexToInt(s);

			if(val > 128)	val = val - 256;

			regs.push_back(val);
			regOcc.push_back(0);
			instructionsType.push_back(0);
		}
		read_regs.close();
	}

	void pipeline()
	{
		int opcode = -1;//, ex_opcode = -1, ma_opcode = -1, wb_opcode = -1;
		int inst;
		int waitOp = 0;
		int continueFor = 0;
		int fr, sr, tr;

		int skipDecode = 0;
		int prev = -1;
		int instructions = 0;

		while(1)
		{
			

			for(int i = 0; i < 15; i++)
			{
				if(regOcc[i] >= 1)	regOcc[i]--;
			}
			if(skipDecode)	skipDecode--;

			//if(cycles > 100)	break;	
			cycles++;

			if(continueFor)
			{
				continueFor--;
				if(continueFor == 0)	break;
				continue;
			}

			prev = waitOp;

			if(waitOp > 0)
			{
				waitOp--;
				if(prev)		
				{
					stalls.push_back(0);
					continue;
				}
			}

			if(prev == 0)
			{
				skipDecode = 1;
				prev = -1;
				waitOp = -10;
			}

			if((cycles != 1) && (!skipDecode))
			{
				opcode = hexToIntChar(I$_hex[inst][0]);
				fr = hexToIntChar(I$_hex[inst][1]);
				sr = hexToIntChar(I$_hex[inst][2]);
				tr = hexToIntChar(I$_hex[inst][3]);

				if(opcode == 0)		//ADD R1, R2, R3; R1 = R2 + R3
				{
					if(!(regOcc[sr]) && !(regOcc[tr]))
					{
						regOcc[fr] = 4;
						regs[fr] = regs[sr] + regs[tr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 1)		//SUB R1, R2, R3; R1 = R2 - R3
				{
					if(!(regOcc[sr]) && !(regOcc[tr]))
					{
						regOcc[fr] = 4;
						regs[fr] = regs[sr] - regs[tr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 2)		//MUL R1, R2, R3; R1 = R2 * R3
				{
					if(!(regOcc[sr]) && !(regOcc[tr]))
					{
						regOcc[fr] = 4;
						regs[fr] = regs[sr] * regs[tr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 3)		//INC R1; R1 = R1 +1
				{
					if(!(regOcc[fr]))
					{
						regOcc[fr] = 4;
						regs[fr] = regs[fr] + 1;
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 4)		//AND R1, R2, R3; R1 = R2 & R3, bit-wise AND
				{
					if(!(regOcc[sr]) && !(regOcc[tr]))
					{
						regOcc[fr] = 4;
						regs[fr] = regs[sr] & regs[tr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 5)		//OR R1, R2, R3 ; R1 = R2 | R3, bit-wise OR
				{
					if(!(regOcc[sr]) && !(regOcc[tr]))
					{
						regOcc[fr] = 4;
						regs[fr] = regs[sr] | regs[tr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 6)		//NOT R1, R2	; R1 = ∼ R2; 1’s complement
				{
					if(!(regOcc[sr]))
					{
						regOcc[fr] = 4;
						regs[fr] = ~ regs[sr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 7)		//XOR R1, R2, R3	; R1 = R2 ⊕ R3, bit-wise XOR
				{
					if(!(regOcc[sr]) && !(regOcc[tr]))
					{
						regOcc[fr] = 4;
						regs[fr] = regs[sr] ^ regs[tr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 8)		//LOAD	R1, R2, X; R1= [R2+X]
				{
					

					if(!(regOcc[sr]))
					{	
						regOcc[fr] = 4;
						regs[fr] = D$[regs[sr] + tr]; 
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 9)		//STORE	R1, R2, X ; [R2+X] = R1
				{
					

					if(!(regOcc[fr]) && !(regOcc[sr]))
					{
						D$[regs[sr] + tr] = regs[fr];
					}
					else
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}
				}
				if(opcode == 10)	//JMP	L1 ;Unconditional jump to L1
				{
					int L1 = 0;
					
					L1 = 16 * L1 + hexToIntChar(I$_hex[inst][1]);
					L1 = 16 * L1 + hexToIntChar(I$_hex[inst][2]);

					if(L1 >= 128)
					{
						L1 = L1 - 256;
					}

					pc = pc + L1 - 1;
					waitOp = 2;
					cycles--;
					continue;
				}

				if(opcode == 11)	//BEQZ	R1, L1 ;Jump to L1 if R1 content is zero.
				{
					if(regOcc[fr] != 0)
					{
						stalls.push_back(1);
						//cout << stalls.size() << "th stall @ " << cycles << "--" << opcode << endl;
						continue;
					}

					int L1 = 0;
					
					L1 = 16 * L1 + hexToIntChar(I$_hex[inst][2]);
					L1 = 16 * L1 + hexToIntChar(I$_hex[inst][3]);

					if(L1 >= 128)
					{
						L1 = L1 - 256;
					}

					

					if(regOcc[fr] == 0)
					{
						if(regs[fr] == 0)
						{
							pc = pc + L1 - 1;
						}
						waitOp = 2;
						cycles--;
						continue;
					}
					else
					{
						waitOp = 2;
						cycles--;
						continue;
					}
				}	

				if(opcode == 15) 	//Program terminates
				{
					continueFor = 3;
					continue;
				}
				

			}

			if(1)
			{
				instructions++;
				instructionsType[hexToIntChar(I$_hex[pc][0])]++;
				inst = pc;
				pc = pc + 1;
			}
			
		}

		ofstream write_D$;
		write_D$.open("DCache.txt");

		for(int i = 0; i < 256; i++)
		{
			int val = D$[i];

			if(val < 0)
			{
				val = val + 256;
			}

			write_D$ << intToHexChar(val/16) ;
			write_D$ << intToHexChar(val % 16)<< endl;
		}

		write_D$.close();

		ofstream write_Output;
		write_Output.open("Output.txt");

		write_Output << instructions << endl; 

		write_Output << (instructionsType[0] + instructionsType[1] + instructionsType[2] + instructionsType[3]) << endl;
		write_Output << (instructionsType[4] + instructionsType[5] + instructionsType[6] + instructionsType[7]) << endl;
		write_Output << (instructionsType[8] + instructionsType[9]) << endl;
		write_Output << (instructionsType[10] + instructionsType[11]) << endl;
		
		write_Output << ((float) cycles/instructions) << endl;

		write_Output << stalls.size() << endl;

		int raw = 0;
		int control = 0;

		for(int i = 0; i < stalls.size(); i++)
		{
			if(stalls[i] == 1)
			{
				write_Output << "S" << i + 1 << " : RAW" << endl;
				raw++;
			}
			else if(stalls[i] == 0)
			{
				write_Output << "S" << i + 1 << " : Branch" << endl;
				control++;
			}
		}

		write_Output << "RAW: " << raw << endl;
		write_Output << "Control: " << control << endl;

		write_Output.close();
	}



};

int main()
{
	Processor P;
	P.pipeline();

	return 0;
}