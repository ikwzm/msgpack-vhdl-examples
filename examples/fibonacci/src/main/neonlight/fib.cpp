// 0.1.9
#include "ccrt.h"

class Mod_main : public NliCCRTBase {
public:
  Mod_main()
 : NliCCRTBase()  {}

  int state;
  uint64_t r1_main;
  uint64_t r3_main;
  uint64_t reg_t2;
  uint64_t reg_t9;
  uint64_t reg_t5_v3;
  uint64_t reg_t7_v5;
  uint64_t reg_t5_v6;
  uint64_t reg_t6_v8;
  uint64_t reg_t6_v9;
  uint64_t reg_t7_v10;
  uint64_t reg_t7_v11;
  uint64_t r4_main_v17;
  uint64_t reg_t14;
  void s_3();
  void s_93();
  void s_6();
  void s_15();
  void s_65();
  void s_69();
  void s_72();
  void s_77();
  void s_82();
  void s_88();
  void s_89();
  void s_91();
  void reset();
  void PostState();
  bool Dispatch();
  void DumpState();
};

void Mod_main::s_3() {
  if (true) {
    state = 93;
  }
}

void Mod_main::s_93() {
  r4_main_v17 = SRAMRead(0UL, NULL);
  if (true) {
    state = 6;
  }
}

void Mod_main::s_6() {
  uint64_t wire_t16;
  wire_t16 = 1UL > r4_main_v17;
  reg_t2 = wire_t16;
  if (true) {
    if (wire_t16) state = 65;
    else
    state = 65;
  }
}

void Mod_main::s_15() {
  if (true) {
    state = 15;
  }
  finish_ = true;
}

void Mod_main::s_65() {
  uint64_t wire_t17;
  wire_t17 = r4_main_v17 == 1UL;
  reg_t14 = wire_t17;
  if (true) {
    if (wire_t17) state = 69;
    else
    state = 72;
  }
}

void Mod_main::s_69() {
  r1_main = 1UL;
  reg_t9 = 0UL;
  if (true) {
    state = 89;
  }
}

void Mod_main::s_72() {
  r3_main = 0UL;
  reg_t2 = 1UL;
  reg_t6_v9 = 1UL;
  reg_t14 = 1UL;
  reg_t7_v11 = 1UL;
  reg_t9 = 1UL;
  if (true) {
    state = 77;
  }
}

void Mod_main::s_77() {
  uint64_t wire_t21;
  uint64_t wire_t19;
  uint64_t wire_t22;
  uint64_t wire_t20;
  wire_t19 = reg_t2 ? r3_main : reg_t5_v6;
  wire_t20 = reg_t14 ? reg_t6_v9 : reg_t6_v8;
  wire_t21 = reg_t9 ? reg_t7_v11 : reg_t7_v10;
  wire_t22 = r4_main_v17 > wire_t21;
  reg_t5_v3 = wire_t19;
  r1_main = wire_t20;
  reg_t7_v5 = wire_t21;
  reg_t2 = wire_t22;
  if (true) {
    if (wire_t22) state = 82;
    else
    state = 88;
  }
}

void Mod_main::s_82() {
  uint64_t wire_t23;
  uint64_t wire_t24;
  wire_t23 = reg_t5_v3 + r1_main;
  reg_t6_v8 = wire_t23;
  reg_t14 = 0UL;
  reg_t5_v6 = wire_t23;
  wire_t24 = reg_t7_v5 + 1UL;
  reg_t9 = 0UL;
  reg_t2 = 0UL;
  r3_main = wire_t23;
  reg_t7_v10 = wire_t24;
  if (true) {
    state = 77;
  }
}

void Mod_main::s_88() {
  r3_main = r1_main;
  reg_t9 = 1UL;
  if (true) {
    state = 89;
  }
}

void Mod_main::s_89() {
  uint64_t wire_t18;
  wire_t18 = reg_t9 ? r3_main : r1_main;
  reg_t6_v8 = wire_t18;
  if (true) {
    state = 91;
  }
}

void Mod_main::s_91() {
  SRAMWrite(1UL, reg_t6_v8, NULL);
  if (true) {
    state = 15;
  }
}

void Mod_main::reset() {
  state = 3;
  finish_ = false;
}

void Mod_main::PostState() {
  //
}

bool Mod_main::Dispatch() {
  switch (state) {
    case 3:
      s_3();
      break;
    case 93:
      s_93();
      break;
    case 6:
      s_6();
      break;
    case 15:
      s_15();
      break;
    case 65:
      s_65();
      break;
    case 69:
      s_69();
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
    case 89:
      s_89();
      break;
    case 91:
      s_91();
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
