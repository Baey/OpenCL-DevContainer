__kernel void helloworld(__global char* in, __global char* out)
{
	int num = get_global_id(0);
	char digit = in[num];
	char tempString[4] = "0000";
	if(digit >= 97 && digit <= 122){
		digit = digit - 32;
	}
	switch(digit){
		case '0':
			break;
		case '1':
			tempString[3] = '1';
			break;
		case '2':
			tempString[2] = '1';
			break;
		case '3':
			tempString[3] = '1';
			tempString[2] = '1';
			break;
		case '4':
			tempString[1] = '1';
			break;
		case '5':
			tempString[3] = '1';
			tempString[1] = '1';
			break;
		case '6':
			tempString[2] = '1';
			tempString[1] = '1';
			break;
		case '7':
			tempString[3] = '1';
			tempString[2] = '1';
			tempString[1] = '1';
			break;
		case '8':
			tempString[0] = '1';
			break;
		case '9':
			tempString[3] = '1';
			tempString[0] = '1';
			break;
		case 'A':
			tempString[2] = '1';
			tempString[0] = '1';
			break;
		case 'B':
			tempString[3] = '1';
			tempString[2] = '1';
			tempString[0] = '1';
			break;
		case 'C':
			tempString[1] = '1';
			tempString[0] = '1';
			break;
		case 'D':
			tempString[3] = '1';
			tempString[1] = '1';
			tempString[0] = '1';
			break;
		case 'E':
			tempString[2] = '1';
			tempString[1] = '1';
			tempString[0] = '1';
			break;
		case 'F':
			tempString[3] = '1';
			tempString[2] = '1';
			tempString[1] = '1';
			tempString[0] = '1';
			break;
	}
	for(int i = 0; i < 4; i++){
		out[num*4 + i] = tempString[i];
	}
	// out[num] = in[num] + 1;
}