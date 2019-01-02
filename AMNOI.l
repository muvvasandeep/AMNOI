%{
	#include"AMNOI.h"
	list_of_methods* temp_list = new list_of_methods;	//Pointer to list of methods
%}

nw 		"\n"
alpha 		[a-zA-Z_]
iden		[a-zA-Z_0-9]
sp 		" "|"\t"
return_type	"int"|"float"|"void"|"double"|"char"|"string"

%%

{return_type}{sp}+{alpha}{iden}*{sp}*"("[^)]*")""{"[^}]*"}"	{
		//Regular expression for template of function definition
		string temp_method_name="";
		string temp_data_type="";
		string temp_input = yytext;
		stringstream ssin(temp_input);
		getline(ssin,temp_data_type,' ');
		getline(ssin,temp_method_name,'(');
		stringstream ss(temp_method_name);
		getline(ss,temp_method_name,' ');
		if(!check_method(temp_method_name,temp_list)){
			method* temp_method = new method;
			temp_method->method_name = temp_method_name;
			temp_method->return_list.push_back(temp_data_type);
			temp_method->temp_count.push_back(temp_method_name);
			temp_method->AMNOI = 1-(((float)(temp_method->return_list.size())-1)/(temp_method->temp_count.size()-1));
			temp_list->list.push_back(temp_method);
		}
		else{
			method* temp_method = get_method(temp_method_name,temp_list);
			if(!check_return_type(temp_data_type,temp_method)){
				temp_method->return_list.push_back(temp_data_type);
				temp_method->temp_count.push_back(temp_method_name);
				temp_method->AMNOI = 1-(((float)(temp_method->return_list.size())-1)/(temp_method->temp_count.size()-1));
			}
			else{
				temp_method->temp_count.push_back(temp_method_name);
				temp_method->AMNOI = 1-(((float)(temp_method->return_list.size())-1)/(temp_method->temp_count.size()-1));
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
	print_sequence(30);
	print_format(20,"method name");
	print_format(10,"AMNOI");
	cout<<endl;
	print_sequence(30);
	for(int i=0;i<temp_list->list.size();i++){
		if(temp_list->list[i]->AMNOI>0){
			AMNOI+=temp_list->list[i]->AMNOI;
		}
		print_format(20,temp_list->list[i]->method_name);
		print_format(10,to_string(temp_list->list[i]->AMNOI));
		cout<<endl;
	}
	print_sequence(30);
	AMNOI = AMNOI/temp_list->list.size();
	cout<<"AMNOI for given cpp program is "<<AMNOI<<endl;
	return 0;
}

