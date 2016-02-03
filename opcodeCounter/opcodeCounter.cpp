#define DEBUG_TYPE	"opcodeCounter"

#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include <map>
#include <string.h>

using namespace llvm;
namespace {
	//struct CountOpcode : public ModulePass {
	struct CountOpcode : public FunctionPass {
		static char ID;

		std::map<std::string, std::map<std::string, int> > variable_op;

		CountOpcode() : FunctionPass(ID){ }

		//bool runOnModule(Module &M) override;
		//bool runOnFunction(Function &F, Module &M);
		bool runOnFunction(Function &F) override;
		bool runOnBasicBlock(BasicBlock &BB);
		bool countBlocksInLoop(Loop *L, unsigned nest, ScalarEvolution *SE);
		void input_info(std::string OpcodeName, std::string var, int trip_count);
		void print_result();

		virtual void getAnalysisUsage(AnalysisUsage& AU) const override {
			AU.setPreservesAll();
			AU.addRequired<LoopInfoWrapperPass>();
			AU.addRequired<ScalarEvolution>();
		}
	};
}

char CountOpcode::ID = 0;
static RegisterPass<CountOpcode> X("opcodeCounter",
									  "Count number of opcode in a functions", false, false);


//===---------------------------------------------------------------------===//
//===- runOnModule(Module &M)
//===---------------------------------------------------------------------===//
/*
bool CountOpcode::runOnModule(Module &M) {
	bool modified = false;

	for(Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
		modified |= runOnFunction(*F, M);
	}

	return modified;
}
*/
//===---------------------------------------------------------------------===//
//===- runOnFunction(Function &F, Module &M)
//===---------------------------------------------------------------------===//
//bool CountOpcode::runOnFunction(Function &F, Module &M) {

bool CountOpcode::runOnFunction(Function &F) {

	bool modified = false;

	llvm::outs() << "\n" <<"====== Function : " << F.getName() << "======\n";
	/*
	for(Function::iterator BB = F.begin(), E = F.end(); BB != E; ++BB) {
		modified |= runOnBasicBlock(*BB);
	}
	*/

	LoopInfo *LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
	ScalarEvolution *SE = &getAnalysis<ScalarEvolution>();

	for (Loop *L : *LI) {
		countBlocksInLoop(L, 0, SE);
	}
	print_result();

	return modified;
}

//===---------------------------------------------------------------------===//
//===- runOnBasicBlock(BasicBlock &BB, Module &M)
//===---------------------------------------------------------------------===//
//bool CountOpcode::runOnBasicBlock(BasicBlock &BB, Module &M) {
/*
bool CountOpcode::runOnBasicBlock(BasicBlock &BB) {
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
*/

bool CountOpcode::countBlocksInLoop(Loop *L, unsigned nest, ScalarEvolution *SE) {
	bool modified = false;
	int trip_count = SE->getSmallConstantTripCount(L);
	int i, end;

	if (trip_count == 0) {
		trip_count = 1;
	}

//	llvm::outs() << "\n" << "Trip SmallConstantTripcount : " << trip_count << "\n";
	llvm::outs() << "\n" << "Trip BackedgeTakencount : " <<
		*(SE->getBackedgeTakenCount(L)) << "\n\n\n";

	for (Loop::block_iterator LI = L->block_begin(), LE = L->block_end();
		 LI != LE; ++LI) {

		for (BasicBlock::iterator BI = (*LI)->begin(), BE = (*LI)->end(); BI != BE;
			 ++BI) {

			std::string OpcodeName = BI->getOpcodeName();
			end = BI->getNumOperands();
/*
			llvm::outs() << OpcodeName << ", ";

			for (i=0;i<end;i++){
				llvm::outs() << BI->getOperand(i)->getName().str() << ",";
			}
			llvm::outs() << "\n";
*/
			if (!OpcodeName.compare("store")) {
			//	llvm::outs() << "\n" << "Trip SmallConstantTripcount : " << trip_count << "\n";
				std::string var = BI->getOperand(1)->getName().str();
				input_info(OpcodeName, var, trip_count);
			} else if (!OpcodeName.compare("load")) {
			//	llvm::outs() << "\n" << "Trip SmallConstantTripcount : " << trip_count << "\n";
				std::string var = BI->getOperand(0)->getName().str();
				input_info(OpcodeName, var, trip_count);
			}
		}
	}

	std::vector<Loop*> subLoops = L->getSubLoops();
	Loop::iterator j;
	for (j = subLoops.begin(); j != subLoops.end(); ++j)
		countBlocksInLoop(*j, nest + 1, SE);

	return modified;
}

void CountOpcode::input_info(std::string OpcodeName, std::string var, int trip_count) {
	if(variable_op.find(var) == variable_op.end()) {
		std::map<std::string, int> opcodeCounter;
		opcodeCounter[OpcodeName] = 1 * trip_count;
		variable_op[var] = opcodeCounter;
	} else {
		std::map<std::string, int> &temp = variable_op[var];
		if( temp.find(OpcodeName) == temp.end()) {
			temp[OpcodeName] = 1 * trip_count;
		} else {
			temp[OpcodeName] = (temp[OpcodeName] + 1) * trip_count;
		}
	}
}

void CountOpcode::print_result(){
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
	variable_op.clear();
}


