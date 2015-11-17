// 0.1.9
#include "ccrt.h"

class Mod_main : public NliCCRTBase {
public:
  Mod_main()
 : NliCCRTBase()  {}

  int state;
  uint64_t r1_main;
  uint64_t r4_main;
  uint64_t reg_t3;
  uint64_t reg_t5;
  uint64_t reg_t2_v4;
  uint64_t reg_t3_v5;
  uint64_t reg_t3_v6;
  uint64_t r4_main_v11;
  uint64_t reg_t1_v13;
  uint64_t reg_t2_v14;
  uint64_t reg_t3_v15;
  uint64_t reg_t9;
  uint64_t reg_t10;
  void s_0();
  void s_57();
  void s_14();
  void s_15();
  void s_43();
  void s_48();
  void reset();
  void PostState();
  bool Dispatch();
  void DumpState();
};

void Mod_main::s_0() {
  r1_main = 0UL;
  reg_t2_v4 = 1UL;
  reg_t3_v5 = 0UL;
  reg_t5 = 0UL;
  reg_t9 = 1UL;
  reg_t10 = 0UL;
  if (true) {
    state = 57;
  }
}

void Mod_main::s_57() {
  r4_main_v11 = SRAMRead(0UL, NULL);
  if (true) {
    state = 43;
  }
}

void Mod_main::s_14() {
  SRAMWrite(1UL, reg_t1_v13, NULL);
  if (true) {
    state = 15;
  }
}

void Mod_main::s_15() {
  if (true) {
    state = 15;
  }
  finish_ = true;
}

void Mod_main::s_43() {
  uint64_t wire_t11;
  uint64_t wire_t12;
  uint64_t wire_t13;
  uint64_t wire_t14;
  wire_t11 = reg_t5 ? r4_main : r1_main;
  wire_t12 = reg_t9 ? reg_t2_v4 : reg_t3;
  wire_t13 = reg_t10 ? reg_t3_v6 : reg_t3_v5;
  wire_t14 = r4_main_v11 > wire_t13;
  reg_t1_v13 = wire_t11;
  reg_t2_v14 = wire_t12;
  reg_t3_v15 = wire_t13;
  reg_t9 = wire_t14;
  if (true) {
    if (wire_t14) state = 48;
    else
    state = 14;
  }
}

void Mod_main::s_48() {
  uint64_t wire_t16;
  uint64_t wire_t15;
  r4_main = reg_t2_v14;
  reg_t5 = 1UL;
  wire_t15 = reg_t2_v14 + reg_t2_v14;
  reg_t10 = 1UL;
  reg_t3 = wire_t15;
  wire_t16 = reg_t3_v15 + 1UL;
  reg_t9 = 0UL;
  r1_main = wire_t15;
  reg_t3_v6 = wire_t16;
  if (true) {
    state = 43;
  }
}

void Mod_main::reset() {
  state = 0;
  finish_ = false;
}

void Mod_main::PostState() {
  //
}

bool Mod_main::Dispatch() {
  switch (state) {
    case 0:
      s_0();
      break;
    case 57:
      s_57();
      break;
    case 14:
      s_14();
      break;
    case 15:
      s_15();
      break;
    case 43:
      s_43();
      break;
    case 48:
      s_48();
      break;
    case kIdleState:
      break;
  }
  return finish_;
}

void Mod_main::DumpState() {
  // dumper;
  printf("Mod_main st=%d\n", state);
}

// copied from ccrt_main.cpp -- begin --
