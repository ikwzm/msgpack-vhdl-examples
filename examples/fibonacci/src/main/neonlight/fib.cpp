// 0.1.9
#include "ccrt.h"

class Mod_main : public NliCCRTBase {
public:
  Mod_main()
 : NliCCRTBase()  {}

  int state;
  uint64_t r1_main;
  uint64_t r3_main;
  uint64_t reg_t3;
  uint64_t reg_t6;
  uint64_t reg_t7_v2;
  uint64_t reg_t8_v3;
  uint64_t reg_t9_v5;
  uint64_t reg_t9_v6;
  uint64_t reg_t7_v7;
  uint64_t reg_t8_v8;
  uint64_t reg_t9_v9;
  uint64_t reg_t16;
  void s_0();
  void s_91();
  void s_15();
  void s_66();
  void s_72();
  void s_77();
  void s_82();
  void s_88();
  void reset();
  void PostState();
  bool Dispatch();
  void DumpState();
};

void Mod_main::s_0() {
  uint64_t wire_t17;
  wire_t17 =!0UL;
  reg_t6 = wire_t17;
  if (true) {
    state = 91;
  }
}

void Mod_main::s_91() {
  reg_t8_v3 = SRAMRead(0UL, NULL);
  if (true) {
    if (reg_t6) state = 66;
    else
    state = 66;
  }
}

void Mod_main::s_15() {
  if (true) {
    state = 15;
  }
  finish_ = true;
}

void Mod_main::s_66() {
  uint64_t wire_t18;
  wire_t18 = 0UL == 1UL;
  reg_t6 = wire_t18;
  if (true) {
    if (wire_t18) state = 72;
    else
    state = 72;
  }
}

void Mod_main::s_72() {
  r1_main = 0UL;
  reg_t6 = 0UL;
  reg_t8_v3 = 1UL;
  reg_t9_v5 = 1UL;
  reg_t3 = 0UL;
  reg_t16 = 0UL;
  if (true) {
    state = 77;
  }
}

void Mod_main::s_77() {
  uint64_t wire_t22;
  uint64_t wire_t19;
  uint64_t wire_t21;
  uint64_t wire_t20;
  wire_t19 = reg_t6 ? reg_t7_v2 : r1_main;
  wire_t20 = reg_t3 ? r3_main : reg_t8_v3;
  wire_t21 = reg_t16 ? reg_t9_v6 : reg_t9_v5;
  wire_t22 = 0UL > wire_t21;
  reg_t7_v7 = wire_t19;
  reg_t8_v8 = wire_t20;
  reg_t9_v9 = wire_t21;
  reg_t3 = wire_t22;
  if (true) {
    if (wire_t22) state = 82;
    else
    state = 88;
  }
}

void Mod_main::s_82() {
  uint64_t wire_t24;
  uint64_t wire_t23;
  wire_t23 = reg_t7_v7 + reg_t8_v8;
  r3_main = wire_t23;
  reg_t3 = 1UL;
  reg_t7_v2 = wire_t23;
  wire_t24 = reg_t9_v9 + 1UL;
  reg_t16 = 1UL;
  reg_t6 = 1UL;
  r1_main = wire_t23;
  reg_t9_v6 = wire_t24;
  if (true) {
    state = 77;
  }
}

void Mod_main::s_88() {
  SRAMWrite(1UL, reg_t8_v8, NULL);
  if (true) {
    state = 15;
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
    case 91:
      s_91();
      break;
    case 15:
      s_15();
      break;
    case 66:
      s_66();
      break;
    case 72:
      s_72();
      break;
    case 77:
      s_77();
      break;
    case 82:
      s_82();
      break;
    case 88:
      s_88();
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
