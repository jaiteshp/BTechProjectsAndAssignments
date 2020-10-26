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

class Instruction
{
private:
public:
	int time;
	string s;
	int fr, sr, tr, fr1, sr1, tr1;
	int r1, r2, r3;
	int L1 = 0;
	int opcode;
	int waitTime = 0;
	int exec_prev = 0;
	int exec_wait = 0;
	int aluOut;
	int aluDone = 0;

	Instruction(string s1)
	{
		s = s + s1;
	}

	void set()
	{
		opcode = hexToIntChar(s[0]);
		fr = hexToIntChar(s[1]);
		sr = hexToIntChar(s[2]);
		tr = hexToIntChar(s[3]);

		fr1 = sr1 = tr1 = -1;

		if(opcode == 10)
		{
			L1 = L1 * 16 + fr;
			L1 = L1 * 16 + sr;
			if(L1 >= 128)
			{
				L1 = L1 - 256;
			}	
		}

		if(opcode == 11)
		{
			L1 = L1 * 16 + sr;
			L1 = L1 * 16 + tr;
			if(L1 >= 128)
			{
				L1 = L1 - 256;
			}			
		}
	}	

	void doALUOp()
	{
		if(opcode == 8)		//LOAD	R1, R2, X; R1= [R2+X]
		{
		}
		if(opcode == 9)		//STORE	R1, R2, X ; [R2+X] = R1
		{
		}
		if(opcode == 0)		//ADD R1, R2, R3; R1 = R2 + R3
		{
			aluOut = r2 + r3;				
		}
		if(opcode == 1)		//SUB R1, R2, R3; R1 = R2 - R3
		{
			aluOut = r2 - r3;
		}
		if(opcode == 2)		//MUL R1, R2, R3; R1 = R2 * R3
		{
			aluOut = r2 * r3;
		}
		if(opcode == 3)		//INC R1; R1 = R1 +1
		{
			aluOut = r1 + 1;
		}
		if(opcode == 4)		//AND R1, R2, R3; R1 = R2 & R3, bit-wise AND
		{
			aluOut = r2 & r3;
		}
		if(opcode == 5)		//OR R1, R2, R3 ; R1 = R2 | R3, bit-wise OR
		{
			aluOut = r2 | r3;
		}
		if(opcode == 6)		//NOT R1, R2	; R1 = ∼ R2; 1’s complement
		{
			aluOut = ~ r2;
		}
		if(opcode == 7)		//XOR R1, R2, R3	; R1 = R2 ⊕ R3, bit-wise XOR
		{
			aluOut = r2 ^ r3;
		}
		if(opcode == 10)	//JMP	L1 ;Unconditional jump to L1
		{

		}
		if(opcode == 11)	//BEQZ	R1, L1 ;Jump to L1 if R1 content is zero.
		{
		}
	}	
};

class superScalarProcessor
{
public:
	int pc = 0;						//Program counter
	int cycles = 0;
	vector <string> I$_hex;		//Each instruction in hexadecimal
	vector <Instruction> I$;
	vector <int> D$;

	vector <int> regs;
	vector <int> regs_tag;	//tag of each register of regs to map to corresponding rr
	vector <int> rr;		
	vector <int> rr_Occ;	//availability of rename regs wher '0' denotes unoccupied(i.e available)
	vector <int> regOcc;	//availability of original regs

	vector <int> rs;
	vector <int> rs_busy;
	vector <int> rs_ready;

	vector <vector <int>> rob;
	int rs_size, rob_size, store_size;
	int cycles = 0;
	int add_l, sub_l, mul_l, inc_l, or_l, not_l, xor_l, load_l, store_l, jmp_l, beqz_l, halt_l;		//'l' stands for the latency of each alu operation

	int findAvailrr()
	{
		for(int i = 0; i < 256; i++)
		{
			if(!(rr_Occ[i]))	return i;
		}
	}

	int findAvailrob()
	{
		int i;

		for(i = 0; i < rob_size; i++)
		{
			if(rob[i][0] == 0)	return i;
		}
		return -1;
	}
	superScalarProcessor(int rs_size1, int rob_size1, int store_size1, int add_l1, int sub_l1, int mul_l1, int inc_l1, int or_l1, int not_l1, int xor_l1, int load_l1, int store_l1, int jmp_l1, int beqz_l1, int halt_l1 )
	{
		regs_tag.resize(16, -1);
		rr.resize(256);
		rr_Occ.resize(256, 0);

		rs_size = rs_size1;
		rs.resize(rs_size);
		rs_busy.resize(rs_size);
		rs_ready.resize(rs_size);

		rob_size = rob_size1;
		for(int i = 0; i < rob_size; i++)
		{
			vector <int> v;	//busy, finished instruction time, instruction address, speculative, valid
			v.resize(6, 0);
			rob.push_back(v);
		}

		store_size = store_size1;
		store.resize(store_size);

		add_l = add_l1;
		sub_l = sub_l1;
		mul_l = mul_l1;
		inc_l = inc_l1;
		or_l = or_l1;
		not_l = not_l1;
		xor_l = xor_l1;
		load_l = load_l1;
		store_l = store_l1; 
		jmp_l = jmp_l1;
		beqz_l = beqz_l1;
		halt_l = halt_l1;

		ifstream read_I$;
		read_I$.open("ICache.txt");
		for(int i = 0; i < 128; i++)
		{	
			string s;
			read_I$ >> s;

			I$_hex.push_back(s);
			Instruction i(s);
			I$.push_back(i);
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
			////cout << hexToInt(s) << endl;
			regOcc.push_back(0);
			instructionsType.push_back(0);
			////cout << s << endl;
		}
		read_regs.close();
	}

	void superScalarPipeline()
	{
		int inst1, inst2;
		int is1 = -1, is2 = -1;		//instruction indices which are ready to be issued
		int opcode1, opcode2;

		while(1)
		{
			cycles++;
			for(int i = 0; i < I$.size(); i++)
			{
				if(I$[i].exec_wait)
				{
					I$[i].exec_wait--;
					I$[i].exec_prev--;
				}
				else if(I$[i].exec_prev == 1)
				{
					//Now write the results
					if(I$[i].opcode != 11)
					{
						I$[i].doALUOp();
						I$[i].aluDone = 1;
						rr_Occ[I$[i].fr1] = 0;	
					}
					else	//Conditional jump
					{
						if(I$[rs[i]].fr1 == -1)
						{
							if(regOcc[I$[rs[i]].fr] == 0)
							{
								pc = pc + regs[I$[i].fr]
							}
						}
						else 
						{
							if(rr_Occ[I$[rs[i]].fr1] == 0)
							{
								pc = pc + regs[I$[i].fr1]
							}
						}
					}				
				}
			}

			for(int i = 0; i < rs_size; i++)
			{
				int notAvailable = 0;

				if(I$[rs[i]].sr1 == -1)
				{
					if(regOcc[I$[rs[i]].sr] != 0)
					{
						notAvailable++;
					}
				}
				else 
				{
					if(rr_Occ[I$[rs[i]].sr1] != 0)
					{
						notAvailable++;
					}
				}
				if(I$[rs[i]].tr1 == -1)
				{
					if(regOcc[I$[rs[i]].tr] != 0)
					{
						notAvailable++;
					}
				}
				else 
				{
					if(rr_Occ[I$[rs[i]].tr1] != 0)
					{
						notAvailable++;
					}
				}

				if(notAvailable == 0)
				{
					rs_ready[i] = 1;
				}
			}

			//Instruction completion and Instruction retire

			if(doWB)
			{
				for(int i = 0; i < rob_size; i++)
				{
					if(rob[i][0] == 1)
					{
						int instAdd = rob[i][3];
						if(I$[instAdd].aluDone)
						{
							regs[I$[instAdd].fr] = aluOut;
							rob[i][1] = 1;
							rob[i][0] = 0;
						}
					}
				}
			}

			//Execute and memory access
			if(doEX)
			{
				if(is1 != -1)
				{
					if(opcode1 == 8)		//LOAD	R1, R2, X; R1= [R2+X]
					{
						I$[is1].exec_wait = load_l;
						I$[is1].exec_prev = load_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 9)		//STORE	R1, R2, X ; [R2+X] = R1
					{	
						I$[is1].exec_wait = store_l;
						I$[is1].exec_prev = store_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 0)		//ADD R1, R2, R3; R1 = R2 + R3
					{
						I$[is1].exec_wait = add_l;
						I$[is1].exec_prev = add_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;					
					}
					if(opcode1 == 1)		//SUB R1, R2, R3; R1 = R2 - R3
					{
						I$[is1].exec_wait = sub_l;
						I$[is1].exec_prev = sub_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 2)		//MUL R1, R2, R3; R1 = R2 * R3
					{
						I$[is1].exec_wait = mul_l;
						I$[is1].exec_prev = mul_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 3)		//INC R1; R1 = R1 +1
					{
						I$[is1].exec_wait = inc_l;
						I$[is1].exec_prev = inc_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 4)		//AND R1, R2, R3; R1 = R2 & R3, bit-wise AND
					{
						I$[is1].exec_wait = and_l;
						I$[is1].exec_prev = and_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 5)		//OR R1, R2, R3 ; R1 = R2 | R3, bit-wise OR
					{
						I$[is1].exec_wait = or_l;
						I$[is1].exec_prev = or_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 6)		//NOT R1, R2	; R1 = ∼ R2; 1’s complement
					{
						I$[is1].exec_wait = not_l;
						I$[is1].exec_prev = not_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 7)		//XOR R1, R2, R3	; R1 = R2 ⊕ R3, bit-wise XOR
					{
						I$[is1].exec_wait = xor_l;
						I$[is1].exec_prev = xor_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode1 == 10)	//JMP	L1 ;Unconditional jump to L1
					{
					}
					if(opcode1 == 11)	//BEQZ	R1, L1 ;Jump to L1 if R1 content is zero.
					{
					}
					if(opcode1 == 15) 	//Program terminates
					{
						break;
					}
				}
				if(is2 != -1)
				{
					if(opcode2 == 8)		//LOAD	R1, R2, X; R1= [R2+X]
					{
						I$[is1].exec_wait = load_l;
						I$[is1].exec_prev = load_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode2 == 9)		//STORE	R1, R2, X ; [R2+X] = R1
					{	
						I$[is1].exec_wait = store_l;
						I$[is1].exec_prev = store_l + 1;	
						rr_Occ[I$[is1].fr1] = 1;
					}
					if(opcode2 == 0)		//ADD R1, R2, R3; R1 = R2 + R3
					{
						I$[is2].exec_wait = add_l;
						I$[is2].exec_prev = add_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;					
					}
					if(opcode2 == 1)		//SUB R1, R2, R3; R1 = R2 - R3
					{
						I$[is2].exec_wait = sub_l;
						I$[is2].exec_prev = sub_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;
					}
					if(opcode2 == 2)		//MUL R1, R2, R3; R1 = R2 * R3
					{
						I$[is2].exec_wait = mul_l;
						I$[is2].exec_prev = mul_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;
					}
					if(opcode2 == 3)		//INC R1; R1 = R1 +1
					{
						I$[is2].exec_wait = inc_l;
						I$[is2].exec_prev = inc_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;
					}
					if(opcode2 == 4)		//AND R1, R2, R3; R1 = R2 & R3, bit-wise AND
					{
						I$[is2].exec_wait = and_l;
						I$[is2].exec_prev = and_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;
					}
					if(opcode2 == 5)		//OR R1, R2, R3 ; R1 = R2 | R3, bit-wise OR
					{
						I$[is2].exec_wait = or_l;
						I$[is2].exec_prev = or_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;
					}
					if(opcode2 == 6)		//NOT R1, R2	; R1 = ∼ R2; 1’s complement
					{
						I$[is2].exec_wait = not_l;
						I$[is2].exec_prev = not_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;
					}
					if(opcode2 == 7)		//XOR R1, R2, R3	; R1 = R2 ⊕ R3, bit-wise XOR
					{
						I$[is2].exec_wait = xor_l;
						I$[is2].exec_prev = xor_l + 1;	
						rr_Occ[I$[is2].fr1] = 1;
					}
					if(opcode2 == 10)	//JMP	L1 ;Unconditional jump to L1
					{
						pc = pc + I$[is2].L1;
					}
					if(opcode2 == 11)	//BEQZ	R1, L1 ;Jump to L1 if R1 content is zero.
					{

					}
					if(opcode2 == 15) 	//Program terminates
					{
						break;
					}
				}
			}

			//Instruction decode
			if(doID)
			{
				//Decode stage
				I$[inst1].set();
				I$[inst2].set();

				//Dispatching instructions into reservation station
				int rs_nonBusy;		//Index of entry in rs that is not busy

				for(rs_nonBusy = 0; rs_nonBusy < rs.size(); rs_nonBusy++)	if(!rs_busy[rs_nonBusy])	break;

				if(rs_nonBusy == rs.size())		//????//structural hazard due to no rs entry available
				else
				{
					rs[rs_nonBusy] = inst1;
					rs_busy[rs_nonBusy] = 1;

					int fr_rr = findAvailrr();

					I$[inst1].time = 2 * cycles;

					int rob_entry1 = findAvailrob();
					rob[rob_entry1][0] = 1;
					rob[rob_entry1][1] = 0;
					rob[rob_entry1][2] = I$[inst1].time;
					rob[rob_entry1][3] = inst1;
					rob[rob_entry1][4] = 0;
					rob[rob_entry1][5] = 0;  

					regs_tag[I$[inst1].fr] = fr_rr;
					I$[inst1].fr1 = fr_rr;
					regOcc[I$[inst1].fr] = 1;

					rr_Occ[fr_rr] = 1;

					int sr_rr, tr_rr;
					int count = 0;

					if(regs_tag[I$[inst1].sr] == -1)
					{
						if(regOcc[I$[inst1].sr] == 1)
						{
							count++;
						}
					}
					else
					{
						sr_rr = regs_tag[I$[inst1].sr];
						I$[inst1].sr1 = sr_rr;

						if(rr_Occ[sr_rr])
						{
							count++;
						}
					}

					if(regs_tag[I$[inst1].tr] == -1)
					{
						if(regOcc[I$[inst1].tr] == 1)
						{
							count++;
						}
					}
					else
					{
						tr_rr = regs_tag[I$[inst1].tr];
						I$[inst1].tr1 = tr_rr;

						if(rr_Occ[tr_rr])
						{
							count++;
						}
					}

					if(count == 0)
					{
						rs_ready[rs_nonBusy] = 1;
					}
				}

				for(rs_nonBusy = 0; rs_nonBusy < rs.size(); rs_nonBusy++)	if(!rs_busy[rs_nonBusy])	break;

				if(rs_nonBusy == rs.size())		//????//structural hazard due to no rs entry available
				else
				{
					rs[rs_nonBusy] = inst2;
					rs_busy[rs_nonBusy] = 1;

					int fr_rr = findAvailrr();

					I$[inst2].time = 2 * cycles + 1;

					int rob_entry2 = findAvailrob();
					rob[rob_entry2][0] = 1;
					rob[rob_entry2][1] = 0;
					rob[rob_entry2][2] = I$[inst2].time;
					rob[rob_entry2][3] = inst2;
					rob[rob_entry2][4] = 0;
					rob[rob_entry2][5] = 0;

					regs_tag[I$[inst2].fr] = fr_rr;
					I$[inst2].fr1 = fr_rr;
					regOcc[I$[inst2].fr] = 1;

					rr_Occ[fr_rr] = 1;

					int sr_rr, tr_rr;
					int count = 0;

					if(regs_tag[I$[inst2].sr] == -1)
					{
						if(regOcc[I$[inst2].sr] == 1)
						{
							count++;
						}
					}
					else
					{
						sr_rr = regs_tag[I$[inst2].sr];
						I$[inst2].sr1 = sr_rr;

						if(rr_Occ[sr_rr])
						{
							count++;
						}
					}

					if(regs_tag[I$[inst2].tr] == -1)
					{
						if(regOcc[I$[inst2].tr] == 1)
						{
							count++;
						}
					}
					else
					{
						tr_rr = regs_tag[I$[inst2].tr];
						I$[inst2].tr1 = tr_rr;

						if(rr_Occ[tr_rr])
						{
							count++;
						}
					}

					if(count == 0)
					{
						rs_ready[rs_nonBusy] = 1;
					}
				}

				//Issuing instructions from rs

				int rs_readyToIssue;
				int ls1 = 0, ls2 = 0;

				for(int i = 0; i < rs.size(); i++)		
				{
					if(rs_ready[i])
					{
						rs_readyToIssue = i;
						rs_busy[rs_readyToIssue] = 0;
						break;
					}
				}

				if(rs_readyToIssue == rs.size())		//Then there is no instruction in rs which is ready to issue.
			}

			//Instruction fetch
			if(doIF)
			{	
				inst1 = pc;
				pc++;
				inst2 = pc;
				pc++;
			}
		}
	}

};

int main()
{
	int rs_size1, int rob_size1, int store_size1, int add_l1, int sub_l1, int mul_l1, int inc_l1, int or_l1, int not_l1, int xor_l1, int load_l1, int store_l1, int jmp_l1, int beqz_l1, int halt_l1;

	cin >> rs_size1, >> rob_size1 >> store_size1 >> add_l1 >> sub_l1 >> mul_l1 >> inc_l1 >> or_l1 >> not_l1 >> xor_l1 >> load_l1 >> store_l1 >> jmp_l1 >> beqz_l1 >> halt_l1;
	
	superScalarProcessor p(rs_size1, rob_size1, store_size1, add_l1, sub_l1, mul_l1, inc_l1, or_l1, not_l1, xor_l1, load_l1, store_l1, jmp_l1, beqz_l1, halt_l1);
	
	p.superScalarPipeline();
	
	return 0;
}
