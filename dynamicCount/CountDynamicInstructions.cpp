#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IRBuilder.h"
#include <string>
#include <map>

using namespace llvm;

namespace {
	struct DICount : public ModulePass {
		static char ID;

		std::map<std::string, std::map<std::string, int> > variable_op;

		llvm::Function *basicBlockInstCountFunction; // Basic block instruction count
		llvm::Function *printresult; // result_count

		DICount() : ModulePass(ID){ }

		bool runOnModule(Module &M) override;
		bool runOnFunction(Function &F, Module &M);
		bool runOnBasicBlock(BasicBlock &BB, Module &M);
		void input_info(std::string OpcodeName, std::string var);
		void print_result();
		void printcalladd(Function::iterator BB, Module &M);
		void addstatistic(std::string FuncName, Function::iterator BB, Module &M);
		virtual void getAnalysisUsage(AnalysisUsage& AU) const override {
			AU.setPreservesAll();
		}
	};
}

char DICount::ID = 0;
static RegisterPass<DICount> X("DIcount",
			 "Count number of opcode in a functions", false, false);


//===---------------------------------------------------------------------===//
//===- runOnModule(Module &M)
//===---------------------------------------------------------------------===//

bool DICount::runOnModule(Module &M) {
	bool modified = false;

	for(Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
		if (!F->getName().equals(StringRef("BasicBlockCount")) and !F->getName().equals(StringRef("PrintResult"))) {
			modified |= runOnFunction(*F, M);
		}

		if ((*F).getName().compare("main") == 0) {
			Function::iterator lastBlock = F->end();
			lastBlock--;
			DICount::printcalladd(lastBlock, M);
		}
	}

	return modified;
}

//===---------------------------------------------------------------------===//
//===- runOnFunction(Function &F, Module &M)
//===---------------------------------------------------------------------===//
bool DICount::runOnFunction(Function &F, Module &M) {
	bool modified = false;
//	llvm::outs() << "\n" <<"====== Function : " << F.getName() << "======\n";

	for(Function::iterator BB = F.begin(), E = F.end(); BB != E; ++BB) {
		modified |= runOnBasicBlock(*BB, M);
		DICount::addstatistic(F.getName().str(), BB, M);

		variable_op.clear();
	}

	return modified;
}

//===---------------------------------------------------------------------===//
//===- runOnBasicBlock(BasicBlock &BB, Module &M)
//===---------------------------------------------------------------------===//
bool DICount::runOnBasicBlock(BasicBlock &BB, Module &M) {
	bool modified = false;

	for (BasicBlock::iterator BI = BB.begin(), BE = BB.end(); BI != BE; ++BI){
		std::string OpcodeName = BI->getOpcodeName();
		if (!OpcodeName.compare("store")) {
			std::string var = BI->getOperand(1)->getName().str();
			input_info(OpcodeName, var);
		} else if (!OpcodeName.compare("load")) {
			std::string var = BI->getOperand(0)->getName().str();
			input_info(OpcodeName, var);
		}
	}
	return modified;
}

void DICount::input_info(std::string OpcodeName, std::string var) {

	if(variable_op.find(var) == variable_op.end()) {
		std::map<std::string, int> opcodeCounter;
		opcodeCounter[OpcodeName] = 1;
		variable_op.insert(std::map<std::string, std::map<std::string, int> >::value_type(var, opcodeCounter));

	} else {
		std::map<std::string, std::map<std::string, int> >::iterator FindIter = variable_op.find(var);

		if (FindIter != variable_op.end()) {
			std::map<std::string, int> &temp = FindIter->second;
			if( temp.find(OpcodeName) == temp.end()) {
				temp[OpcodeName] = 1;
			} else {
				temp[OpcodeName] = temp[OpcodeName] + 1;
			}
		}
	}
}

void DICount::print_result(){
	std::map<std::string, std::map<std::string, int> >::iterator outer_i =
		variable_op.begin();

	while(outer_i != variable_op.end()) {
		llvm::outs() << outer_i->first << "\n";
		std::map< std::string, int> &temp = outer_i->second;
		std::map< std::string, int>::iterator i = temp.begin();

		while (i != temp.end()) {
			llvm::outs()  <<"\t"<< i->first << ": " << i->second << "\n";
			i++;
		}
		llvm::outs()  << "\n";

		outer_i++;
		temp.clear();
	}
}

void DICount::addstatistic(std::string FuncName, Function::iterator BB, Module &M) {
	basicBlockInstCountFunction = M.getFunction("BasicBlockCount");

	if (basicBlockInstCountFunction == NULL) {
		llvm::outs() << "basicBlockInstCountFunction is NULL!!!!\n";
	} else {
		Value *Func, *myStr1, *myStr2, *myInt;

		// Create an IRBuilder instance and set the insert point
		// to the very last instruction of main
		IRBuilder<> builder(BB);
		BasicBlock::iterator lastIns = BB->end();
		lastIns--;
		builder.SetInsertPoint(lastIns);

		// Create a call to the printFunction with no arguments
		std::map<std::string, std::map<std::string, int> >::iterator outer_i =
			variable_op.begin();

		Func = builder.CreateGlobalStringPtr(FuncName);

		while(outer_i != variable_op.end()) {
			//llvm::outs() << outer_i->first << "\n";
			myStr1 = builder.CreateGlobalStringPtr(outer_i->first);
			std::map< std::string, int> &temp = outer_i->second;
			std::map< std::string, int>::iterator i = temp.begin();

			while (i != temp.end()) {
				//llvm::outs()  <<"\t"<< i->first << ": " << i->second << "\n";
				myStr2 = builder.CreateGlobalStringPtr(i->first);
				myInt = ConstantInt::get(Type::getInt32Ty(M.getContext()), i->second);

				builder.CreateCall(basicBlockInstCountFunction, {Func, myStr1, myStr2, myInt});
				i++;
			}
			//		llvm::outs()  << "\n";

			outer_i++;
			temp.clear();
		}
	}
}

void DICount::printcalladd(Function::iterator BB, Module &M) {
	printresult = M.getFunction("PrintResult");

	if (printresult == NULL) {
		llvm::outs() << "print_result function is NULL!!!!\n";
	} else {
		// Create an IRBuilder instance and set the insert point
		// to the very last instruction of main
		IRBuilder<> builder(BB);
		BasicBlock::iterator lastIns = BB->end();
		lastIns--;
		builder.SetInsertPoint(lastIns);

		// Create a call to the printFunction with no arguments
		builder.CreateCall(printresult);
	}
}
