// 0.1.9
#include "ccrt.h"

class Mod_main : public NliCCRTBase {
public:
  Mod_main()
 : NliCCRTBase()  {}

  int state;
  uint64_t r1_main;
  uint64_t r3_main;
  uint64_t r7_main;
  uint64_t r6_main;
  uint64_t r14_main;
  uint64_t reg_t3_v1;
  uint64_t reg_t2_v3;
  uint64_t reg_t4_v4;
  uint64_t reg_t4_v5;
  uint64_t reg_t3_v6;
  uint64_t reg_t2_v9;
  uint64_t r6_main_v17;
  uint64_t r9_main_v18;
  uint64_t reg_t9;
  uint64_t reg_t10;
  void s_0();
  void s_65();
  void s_3();
  void s_13();
  void s_66();
  void s_20();
  void s_63();
  void s_50();
  void s_54();
  void reset();
  void PostState();
  bool Dispatch();
  void DumpState();
};

void Mod_main::s_0() {
  if (true) {
    state = 65;
  }
}

void Mod_main::s_65() {
  r7_main = SRAMRead(0UL, NULL);
  if (true) {
    state = 3;
  }
}

void Mod_main::s_3() {
  uint64_t wire_t12;
  uint64_t wire_t13;
  wire_t12 = r7_main == 0UL;
  wire_t13 =!wire_t12;
  r6_main_v17 = wire_t13;
  if (true) {
    if (wire_t13) state = 13;
    else
    state = 63;
  }
}

void Mod_main::s_13() {
  reg_t2_v9 = 0UL;
  reg_t3_v6 = 1UL;
  reg_t4_v4 = 0UL;
  reg_t9 = 0UL;
  reg_t10 = 1UL;
  r6_main = 0UL;
  if (true) {
    state = 66;
  }
}

void Mod_main::s_66() {
  r9_main_v18 = SRAMRead(1UL, NULL);
  if (true) {
    state = 50;
  }
}

void Mod_main::s_20() {
  SRAMWrite(2UL, reg_t2_v3, NULL);
  if (true) {
    state = 63;
  }
}

void Mod_main::s_63() {
  if (true) {
    state = 63;
  }
  finish_ = true;
}

void Mod_main::s_50() {
  uint64_t wire_t14;
  uint64_t wire_t15;
  uint64_t wire_t16;
  uint64_t wire_t17;
  wire_t14 = reg_t9 ? r14_main : reg_t3_v6;
  wire_t15 = reg_t10 ? reg_t2_v9 : r3_main;
  wire_t16 = r6_main ? reg_t4_v5 : reg_t4_v4;
  wire_t17 = r9_main_v18 > wire_t16;
  reg_t3_v1 = wire_t14;
  reg_t2_v3 = wire_t15;
  r1_main = wire_t16;
  r6_main = wire_t17;
  if (true) {
    if (wire_t17) state = 54;
    else
    state = 20;
  }
}

void Mod_main::s_54() {
  uint64_t wire_t18;
  uint64_t wire_t19;
  r3_main = reg_t3_v1;
  wire_t18 = reg_t3_v1 + reg_t2_v3;
  reg_t10 = 0UL;
  r6_main = 1UL;
  reg_t9 = 1UL;
  r14_main = wire_t18;
  wire_t19 = r1_main + 1UL;
  reg_t2_v9 = wire_t18;
  reg_t4_v5 = wire_t19;
  if (true) {
    state = 50;
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
    case 65:
      s_65();
      break;
    case 3:
      s_3();
      break;
    case 13:
      s_13();
      break;
    case 66:
      s_66();
      break;
    case 20:
      s_20();
      break;
    case 63:
      s_63();
      break;
    case 50:
      s_50();
      break;
    case 54:
      s_54();
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
