%{
	#include"AMNOI.h"
	list_of_methods* temp_list = new list_of_methods;	//Pointer to list of methods
%}

nw 		"\n"
alpha 		[a-zA-Z_]
iden		[a-zA-Z_0-9]
sp 		" "|"\t"
return_type	"int"|"float"|"void"|"double"|"char"|"string"
visibility	"public"|"private"|"protected"|"internal"

%%

{sp}*({visibility}|((protected){sp}+(internal))){sp}+((override){sp}+)?{alpha}{iden}+{sp}+{alpha}{iden}*{sp}*"("[^)]*")"[^{]*"{"[^}]*"}"	{
		//Regular expression for template of function definition in C#
		string temp_visibility = "";
		string temp_method_name = "";
		string temp_data_type = "";
		string temp = yytext;
		int i=0;
		while(temp[i]==' '){
			i++;
		}
		string temp_input = temp.substr(i,temp.length()-i);
		vector<string> result;
		std::istringstream iss(temp_input);
		for(std::string s; iss >> s; )
    			result.push_back(s);
    		if(result[0]=="protected"&&result[1]=="internal"&&result[2]=="override"){
    			temp_data_type = result[3];
    			temp_method_name = result[4].substr(0,result[4].find('('));
    		}
    		else if((result[0]=="protected"&&result[1]=="internal")||(result[1]=="override")){
    			temp_data_type = result[2];
    			temp_method_name = result[3].substr(0,result[3].find('('));
    		}
    		else{
    			temp_data_type = result[1];
    			temp_method_name = result[2].substr(0,result[2].find('('));
    		}
		if(!check_method(temp_method_name,temp_list)){
			method* temp_method = new method;
			temp_method->method_name = temp_method_name;
			temp_method->return_list.push_back(temp_data_type);
			temp_method->temp_count.push_back(temp_method_name);
			temp_method->AMNOI = 1-(((float)(temp_method->return_list.size())-1)/(temp_method->temp_count.size()-1));
			temp_method->AMNOI = -1;
			temp_list->list.push_back(temp_method);
		}
		else{
			method* temp_method = get_method(temp_method_name,temp_list);
			if(!check_return_type(temp_data_type,temp_method)){
				temp_method->return_list.push_back(temp_data_type);
				temp_method->temp_count.push_back(temp_method_name);
				if(temp_method->temp_count.size()!=0)
					temp_method->AMNOI = 1-(((float)(temp_method->return_list.size())-1)/(temp_method->temp_count.size()-1));
				else
					temp_method->AMNOI = -1;
			}
			else{
				temp_method->temp_count.push_back(temp_method_name);
				if(temp_method->temp_count.size()!=0)
					temp_method->AMNOI = 1-(((float)(temp_method->return_list.size())-1)/(temp_method->temp_count.size()-1));
				else
					temp_method->AMNOI = -1;
			}
		}
	}
{nw}	{}
.	{}

%%

int main(int argc, char *argv[]){
	if (argc != 2) {
		 printf("\nUsage: <exefile> <inputfile>\n\n");
		 exit(0);
	}
	yyin = fopen(argv[1], "r");
	yylex();
	float AMNOI = 0;
	int n = 0;
	print_sequence(50);
	print_format(40,"method name");
	print_format(10,"AMNOI");
	cout<<endl;
	print_sequence(50);
	for(int i=0;i<temp_list->list.size();i++){
		if(temp_list->list[i]->AMNOI>0){
			AMNOI+=temp_list->list[i]->AMNOI;
			n++;
		}
		print_format(40,temp_list->list[i]->method_name);
		print_format(10,to_string(temp_list->list[i]->AMNOI));
		cout<<endl;
	}
	print_sequence(50);
	if(n>0){
		AMNOI = AMNOI/n;
		cout<<"AMNOI for given cpp program is "<<AMNOI<<endl;
	}
	else{
		AMNOI = 0;
		cout<<"No overloaded functions"<<endl;
	}
	return 0;
}
