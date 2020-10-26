#include<iostream>
#include<string>
#include<vector>
#include<math.h>
#include<fstream>

using namespace std;

string readInstruction(string s)
{
	string b;	//Binary address
	for(int i = 0; i < s.size(); i++)		//Assuming hex number is given without 0x prefix
	{
		if(s[i] == '0')	b = b + "0000";
		else if(s[i] == '1')	b = b + "0001";
		else if(s[i] == '2')	b = b + "0010";
		else if(s[i] == '3')	b = b + "0011";
		else if(s[i] == '4')	b = b + "0100";
		else if(s[i] == '5')	b = b + "0101";
		else if(s[i] == '6')	b = b + "0110";
		else if(s[i] == '7')	b = b + "0111";
		else if(s[i] == '8')	b = b + "1000";
		else if(s[i] == '9')	b = b + "1001";
		else if(s[i] == 'A')	b = b + "1010";
		else if(s[i] == 'B')	b = b + "1011";
		else if(s[i] == 'C')	b = b + "1100";
		else if(s[i] == 'D')	b = b + "1101";
		else if(s[i] == 'E')	b = b + "1110";
		else if(s[i] == 'F')	b = b + "1111";
	}

	return b;
}

long int parseString(string b)	//Takes a binary string as input and returns it's integer value
{
	if(b.size() == 0)	return 0;

	long int t = 0;

	for(int i = 0; i < b.size(); i++)
	{
		if(b[i] == '0')	t = 2 * t;
		else	t = (2 * t) + 1;
	}
	return t;
}

class cacheBlock
{					
public:
	long int tag;
	int valid;
	int dirty;
	long int time = 0;
	long int setIndexInt;	//For usage in determining compulsory miss

	cacheBlock(){}

	cacheBlock(long int t, int v, int d)
	{
		tag = t;
		valid = v;
		dirty = d;
	}
};

class Cache
{
public:
	int replacementPolicy;
	long int nSets, setIndexWidth;
	long int nBlocksPerSet;
	long int size;			//size is the cacheSize
	int assosciativity;
	long int blockSize, blockOffsetWidth;	//blockoffsetwidth is the number of bits reqd to represent blockoffset

	long int time = 0;

	long int readAccesses = 0, writeAccesses = 0, cacheAccesses = 0;
	long int readMisses = 0, writeMisses = 0;
	long int cacheMisses = 0, compulsoryMisses = 0, capacityMisses = 0, conflictMisses = 0;
	long int dirtyBlocksEvicted = 0;

	vector < vector <cacheBlock> > v;
	vector < cacheBlock> accessed;		//This vector contains all the blocks which are accessed in the past

	Cache(long int s, long int nS, long int nBpS, long int as, long int bs, long int rp)
	{
		size = s;
		nSets = nS;
		nBlocksPerSet = nBpS;
		assosciativity = as;
		blockSize = bs;
		replacementPolicy = rp;
		blockOffsetWidth = log2(blockSize);
		setIndexWidth = log2(nSets);

		for(long int i = 0; i < nSets; i++)	
		{
			for(long int j = 0; j < nBlocksPerSet; j++)
			{
				vector <cacheBlock> vs;		//Initialising each row of cache
				vs.resize(nBlocksPerSet);
				v.push_back(vs);
			}
		}

		for(long int i = 0; i < nSets; i++)
		{
			for(long int j = 0; j < nBlocksPerSet; j++)
			{
				cacheBlock cb(-1, 0 , 0);	//Initialising each cacheBlock
				v[i].push_back(cb);
			}
		}

	}

	void read(string s)
	{
		string setIndexString;
		string tagString;

		long int tagInt;
		long int setIndexInt;

		for(long int i = s.size() - blockOffsetWidth - setIndexWidth; i < s.size() - blockOffsetWidth; i++)
		{
			if(nSets == 1)	break;
			setIndexString = setIndexString + s[i];
		}

		for(long int i = 1; i < s.size() - setIndexWidth - blockOffsetWidth; i++)
		{
			tagString = tagString + s[i];
		}

		tagInt = parseString(tagString);			//Tagint contains the integer tag value of cacheblock to be read
		setIndexInt = parseString(setIndexString);

		long int found = 0, reqdColumn;
		for(long int i = 0; i < nBlocksPerSet; i++)
		{
			if((v[setIndexInt][i].tag == tagInt) && (v[setIndexInt][i].valid == 1))
			{
				found++;
				reqdColumn = i;
				break;
			} 
		}

		if(found != 0)	// When a block with a matching tag is found
		{
			v[setIndexInt][reqdColumn].valid = 1;
			v[setIndexInt][reqdColumn].time = time;
		}
		else		//When reqd tag cacheBlock isnt found in that particular set
		{
			cacheMisses++;
			readMisses++;

			long int alreadyAccessed = 0;

			for(long int i = 0; i < accessed.size(); i++)
			{
				if((tagInt == accessed[i].tag) && (setIndexInt == accessed[i].setIndexInt))	
				{
					alreadyAccessed++;
					break;
				}
			}

			
			if(alreadyAccessed == 0)	//Compulsory miss
			{
				compulsoryMisses++;
			}
			else		//Find wheteher the miss is compulsory or capacity miss
			{
					if(assosciativity == 0)
					{
						capacityMisses++;
					}	
					else	conflictMisses++;	
			}				
			

			//Whatever may be the reason of miss, we have to now put reqd cacheblock in that set
			//If there is an invalid block available, we will use that. Otherwise we will use Replacement Policy.

			long int foundInvalid = 0, reqdColumn;
			for(long int i = 0; i < nBlocksPerSet; i++)
			{
				if(v[setIndexInt][i].valid == 0)
				{
					foundInvalid++;
					reqdColumn = i;
					break;					
				}
			}

			if(foundInvalid != 0)
			{
				v[setIndexInt][reqdColumn].valid = 1;
				v[setIndexInt][reqdColumn].tag = tagInt;
				v[setIndexInt][reqdColumn].time = time;
				v[setIndexInt][reqdColumn].dirty = 0;
			}
			else		//Now we proceed according to replacementPolicy
			{
				if(replacementPolicy == 0)		//Random Replacement
				{
					reqdColumn = (rand() % nBlocksPerSet);

					if(v[setIndexInt][reqdColumn].dirty == 1)	dirtyBlocksEvicted++;

					v[setIndexInt][reqdColumn].valid = 1;
					v[setIndexInt][reqdColumn].dirty = 0;
					v[setIndexInt][reqdColumn].tag = tagInt;
					v[setIndexInt][reqdColumn].time = time;
				}
				else if(replacementPolicy == 1)		//LRU policy
				{
					long int minTime = time;

					for(long int i = 0; i < nBlocksPerSet; i++)
					{
						if(v[setIndexInt][i].time <= minTime)	
						{
							minTime = v[setIndexInt][i].time;
							reqdColumn = i;
						}
					}

					if(v[setIndexInt][reqdColumn].dirty == 1)	
					{
						dirtyBlocksEvicted++;
					}
					v[setIndexInt][reqdColumn].valid = 1;
					v[setIndexInt][reqdColumn].dirty = 0;
					v[setIndexInt][reqdColumn].tag = tagInt;
					v[setIndexInt][reqdColumn].time = time;
				}	
				else if(replacementPolicy == 2)		//Pseudo LRU policy
				{
					long int maxTime = time;

					for(long int i = 0; i < nBlocksPerSet; i++)
					{
						if(v[setIndexInt][i].time >= maxTime)	
						{
							maxTime = v[setIndexInt][i].time
							;
						}
					}

					for(long int i = 0; i < nBlocksPerSet; i++)
					{
						if(v[setIndexInt][i].time < maxTime)
						{
							reqdColumn = i;
							break;
						}
					}

					if(v[setIndexInt][reqdColumn].dirty == 1)	dirtyBlocksEvicted++;
					v[setIndexInt][reqdColumn].valid = 1;
					v[setIndexInt][reqdColumn].dirty = 0;
					v[setIndexInt][reqdColumn].tag = tagInt;
					v[setIndexInt][reqdColumn].time = time;
				}
			}
		}
		cacheBlock c1(tagInt, 1, 0);	//Cache blocks written now will be pushed to accessed vector along with the row(setIndexInt) in which they are stored
		c1.setIndexInt =setIndexInt;
		accessed.push_back(c1);	
	}

	void write(string s)
	{
		string setIndexString;
		string tagString;

		long int tagInt;
		long int setIndexInt;

		for(long int i = s.size() - blockOffsetWidth - setIndexWidth; i < s.size() - blockOffsetWidth; i++)
		{
			if(nSets == 1)	break;
			setIndexString = setIndexString + s[i];
		}

		for(long int i = 1; i < s.size() - setIndexWidth - blockOffsetWidth; i++)
		{
			tagString = tagString + s[i];
		}

		tagInt = parseString(tagString);
		setIndexInt = parseString(setIndexString);

		long int found = 0, reqdColumn;
		for(long int i = 0; i < nBlocksPerSet; i++)
		{
			if((v[setIndexInt][i].tag == tagInt) && (v[setIndexInt][i].valid == 1))
			{
				found++;
				reqdColumn = i;
				break;
			} 
		}

		if(found != 0)	// When a block with a matching tag is found
		{
			v[setIndexInt][reqdColumn].valid = 1;
			v[setIndexInt][reqdColumn].dirty = 1;
			v[setIndexInt][reqdColumn].time = time;
		}
		else		//When reqd tag cacheBlock isnt found in that particular set
		{
			cacheMisses++;
			writeMisses++;

			long int alreadyAccessed = 0;

			for(long int i = 0; i < accessed.size(); i++)
			{
				if((tagInt == accessed[i].tag) && (setIndexInt == accessed[i].setIndexInt))	
				{
					alreadyAccessed++;
					break;
				}
			}

			if(alreadyAccessed == 0)	//Compulsory miss
			{
				compulsoryMisses++;
			}
			else			//Find whether the miss is compulsory or conflict miss
			{
					if(assosciativity == 0)
					{
						capacityMisses++;
					}	
					else	conflictMisses++;	
			}

			//Whatever may be the reason of miss, we have to now put reqd cacheblock in that set
			//If there is an invalid block available, we will use that. Otherwise we will use Replacement Policy.

			long int foundInvalid = 0, reqdColumn;
			for(long int i = 0; i < nBlocksPerSet; i++)
			{
				if(v[setIndexInt][i].valid == 0)
				{
					foundInvalid++;
					reqdColumn = i;
					break;					
				}
			}

			if(foundInvalid != 0)
			{
				v[setIndexInt][reqdColumn].valid = 1;
				v[setIndexInt][reqdColumn].tag = tagInt;
				v[setIndexInt][reqdColumn].time = time;
				v[setIndexInt][reqdColumn].dirty = 1;
			}
			else		//Now we proceed according to replacementPolicy
			{
				if(replacementPolicy == 0)		//Random Replacement
				{
					reqdColumn = (rand() % nBlocksPerSet);

					if(v[setIndexInt][reqdColumn].dirty == 1)	dirtyBlocksEvicted++;

					v[setIndexInt][reqdColumn].valid = 1;
					v[setIndexInt][reqdColumn].dirty = 1;
					v[setIndexInt][reqdColumn].tag = tagInt;
					v[setIndexInt][reqdColumn].time = time;
				}
				else if(replacementPolicy == 1)		//LRU
				{
					long int minTime = time;

					for(long int i = 0; i < nBlocksPerSet; i++)
					{
						if(v[setIndexInt][i].time <= minTime)	
						{
							minTime = v[setIndexInt][i].time;
							reqdColumn = i;
						}
					}

					if(v[setIndexInt][reqdColumn].dirty == 1)	
					{
						dirtyBlocksEvicted++;
					}
					v[setIndexInt][reqdColumn].valid = 1;
					v[setIndexInt][reqdColumn].dirty = 1;
					v[setIndexInt][reqdColumn].tag = tagInt;
					v[setIndexInt][reqdColumn].time = time;
				}	
				else if(replacementPolicy == 2)		//Pseudo LRU
				{
					long int maxTime = time;

					for(long int i = 0; i < nBlocksPerSet; i++)
					{
						if(v[setIndexInt][i].time >= maxTime)	
						{
							maxTime = v[setIndexInt][i].time
							;
						}
					}

					for(long int i = 0; i < nBlocksPerSet; i++)
					{
						if(v[setIndexInt][i].time < maxTime)
						{
							reqdColumn = i;
							break;
						}
					}

					if(v[setIndexInt][reqdColumn].dirty == 1)	dirtyBlocksEvicted++;
					v[setIndexInt][reqdColumn].valid = 1;
					v[setIndexInt][reqdColumn].dirty = 1;
					v[setIndexInt][reqdColumn].tag = tagInt;
					v[setIndexInt][reqdColumn].time = time;
				}
			}
		}
		cacheBlock c1(tagInt, 1, 0);		//Cache blocks written now will be pushed to accessed vector along with the row(setIndexInt) in which they are stored
		c1.setIndexInt = setIndexInt;
		accessed.push_back(c1);
	}
};

int main()
{
	ifstream read;
	read.open("input.txt");

	ofstream write;
	write.open("output.txt");

	srand(time(0));
	long int cacheSize, blockSize, assosciativity, replacementPolicy;

	read >> cacheSize >> blockSize >> assosciativity >> replacementPolicy;

	if(assosciativity == 0)		//Fully assosciative
	{
		Cache c(cacheSize, 1, (cacheSize / blockSize), assosciativity, blockSize, replacementPolicy);	//Cache(int s, int nS, int nBpS, int as, int bs, int rp)
		if(1)
		{	
		
			string instruction;

			while(read >> instruction)
			{
				string binaryInstruction;

				binaryInstruction = readInstruction(instruction);	//reads hexadecimal input as a string and returns its binary version

				c.cacheAccesses++;
				c.time = c.time + 1;

				if(binaryInstruction[0] == '0')			//Read instruction
				{
					c.readAccesses++;
					c.read(binaryInstruction);
				}
				else
				{
					c.writeAccesses++;
					c.write(binaryInstruction);
				}
			}

			write << c.size << endl;
			write << c.blockSize << endl;
			write << c.assosciativity << endl;
			write << c.replacementPolicy << endl;
			write << c.cacheAccesses << endl;
			write << c.readAccesses << endl;
			write << c.writeAccesses << endl;
			write << c.cacheMisses << endl;
			write << c.compulsoryMisses << endl;
			write << c.conflictMisses << endl;
			write << c.capacityMisses << endl;
			write << c.readMisses << endl;
			write << c.writeMisses << endl;
			write << c.dirtyBlocksEvicted << endl;
		}
	}
	else if(assosciativity == 1)	//Direct mapped
	{
		Cache c(cacheSize, (cacheSize / blockSize), 1, assosciativity, blockSize, replacementPolicy);
		if(1)
		{	
		
			string instruction;

			while(read >> instruction)
			{
				string binaryInstruction;

				binaryInstruction = readInstruction(instruction);	//reads hexadecimal input as a string and returns its binary version

				c.cacheAccesses++;
				c.time = c.time + 1;

				if(binaryInstruction[0] == '0')			//Read instruction
				{
					c.readAccesses++;
					c.read(binaryInstruction);
				}
				else
				{
					c.writeAccesses++;
					c.write(binaryInstruction);
				}
			}

			write << c.size << endl;
			write << c.blockSize << endl;
			write << c.assosciativity << endl;
			write << c.replacementPolicy << endl;
			write << c.cacheAccesses << endl;
			write << c.readAccesses << endl;
			write << c.writeAccesses << endl;
			write << c.cacheMisses << endl;
			write << c.compulsoryMisses << endl;
			write << c.conflictMisses << endl;
			write << c.capacityMisses << endl;
			write << c.readMisses << endl;
			write << c.writeMisses << endl;
			write << c.dirtyBlocksEvicted << endl;
		}
	}
	else							//set-assosciative 
	{
		Cache c(cacheSize, ((cacheSize / blockSize) / assosciativity), assosciativity, assosciativity, blockSize, replacementPolicy);
		if(1)
		{	
		
			string instruction;

			while(read >> instruction)
			{
				string binaryInstruction;

				binaryInstruction = readInstruction(instruction);	//reads hexadecimal input as a string and returns its binary version

				c.cacheAccesses++;
				c.time = c.time + 1;

				if(binaryInstruction[0] == '0')			//Read instruction
				{
					c.readAccesses++;
					c.read(binaryInstruction);
				}
				else
				{
					c.writeAccesses++;
					c.write(binaryInstruction);
				}
			}

			write << c.size << endl;
			write << c.blockSize << endl;
			write << c.assosciativity << endl;
			write << c.replacementPolicy << endl;
			write << c.cacheAccesses << endl;
			write << c.readAccesses << endl;
			write << c.writeAccesses << endl;
			write << c.cacheMisses << endl;
			write << c.compulsoryMisses << endl;
			write << c.conflictMisses << endl;
			write << c.capacityMisses << endl;
			write << c.readMisses << endl;
			write << c.writeMisses << endl;
			write << c.dirtyBlocksEvicted << endl;
		}
	}
	read.close();
	write.close();
	return 0;
}
