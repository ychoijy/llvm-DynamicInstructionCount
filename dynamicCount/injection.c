#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_VAR_LIST 100
#define MAX_FUNC_LIST 50
#define MAX_LEN	30
#define LOAD 0
#define STORE 1

struct op {
	char op_name[MAX_LEN];
	int count;
};

struct var {
	char var_name[MAX_LEN];
	struct op *op[2];
};

struct func {
	char func_name[MAX_LEN];
	struct var *var_list[MAX_VAR_LIST];
};

struct func func_list[MAX_FUNC_LIST];


void BasicBlockCount(char *function, char *variable, char *operation, int count)
{
	int i,j;
	int flag1 = 0, flag2 = 0;

	for (i=0;i<MAX_FUNC_LIST && func_list[i].var_list[0] ;i++) {
		if (!strcmp(function, func_list[i].func_name)) {
			flag1 = 1;

			for( j=0;j<MAX_VAR_LIST && func_list[i].var_list[j]; j++) {
				if (!strcmp(variable, func_list[i].var_list[j]->var_name)) {
					flag2 = 1;
					if (!strcmp(operation, "load")) {
						if (func_list[i].var_list[j]->op[LOAD]) {
							func_list[i].var_list[j]->op[LOAD]->count++;
						} else {
							struct op *op;
							op = malloc(sizeof(struct op));
							op->count = 1;
							strcpy(op->op_name, operation);

							func_list[i].var_list[j]->op[LOAD] = op;
						}
					} else if (!strcmp(operation, "store")) {
						if (func_list[i].var_list[j]->op[STORE]) {
							func_list[i].var_list[j]->op[STORE]->count =
								func_list[i].var_list[j]->op[STORE]->count + 1;

						} else {
							struct op *op;
							op = malloc(sizeof(struct op));
							op->count = 1;
							strcpy(op->op_name, operation);
							func_list[i].var_list[j]->op[STORE] = op;
						}
					} else {
						printf("op is not both load and store");
					}

					break;
				}
			}

			if (flag2 == 0 && j != MAX_VAR_LIST) {
				struct var *var;
				struct op *op;

				var = malloc(sizeof(struct var));
				op = malloc(sizeof(struct op));

				op->count = 1;

				strcpy(var->var_name, variable);
				func_list[i].var_list[j] = var;

				if (!strcmp(operation, "load")) {
					strcpy(op->op_name, operation);
					func_list[i].var_list[j]->op[LOAD] = op;
					func_list[i].var_list[j]->op[STORE] = NULL;
				} else if (!strcmp(operation, "store")) {
					strcpy(op->op_name, operation);
					func_list[i].var_list[j]->op[STORE] = op;
					func_list[i].var_list[j]->op[LOAD] = NULL;
				} else {
					printf("op is not both load and store");
				}
			}

			break;
		}
	}

	if (flag1 == 0 && i != MAX_FUNC_LIST) {
		struct var *var;
		struct op *op;

		var = malloc(sizeof(struct var));
		op = malloc(sizeof(struct op));

		strcpy(func_list[i].func_name, function);
		strcpy(var->var_name, variable);

		func_list[i].var_list[0] = var;

		op->count = 1;

		if (!strcmp(operation, "load")) {
			strcpy(op->op_name, operation);
			func_list[i].var_list[0]->op[LOAD] = op;
			func_list[i].var_list[0]->op[STORE] = NULL;
		} else if (!strcmp(operation, "store")) {
			strcpy(op->op_name, operation);
			func_list[i].var_list[0]->op[STORE] = op;
			func_list[i].var_list[0]->op[LOAD] = NULL;
		} else {
			printf("op is not both load and store");
		}
	}
}

void PrintResult(void)
{
	int i,j;

	for (i=0;i<MAX_FUNC_LIST && func_list[i].var_list[0]; i++) {
		printf("Function : %s\n", func_list[i].func_name);
		for (j=0;j<MAX_VAR_LIST && func_list[i].var_list[j] ;j++) {
			printf("\t\tvariable : %s\n", func_list[i].var_list[j]->var_name);
			if (func_list[i].var_list[j]->op[LOAD]) {
				printf("\t\t\t\t- load num : %d\n", func_list[i].var_list[j]->op[LOAD]->count);
			}

			if (func_list[i].var_list[j]->op[STORE]) {
				printf("\t\t\t\t- store num : %d <<<-----\n", func_list[i].var_list[j]->op[STORE]->count);
			}
		}
	}
}
