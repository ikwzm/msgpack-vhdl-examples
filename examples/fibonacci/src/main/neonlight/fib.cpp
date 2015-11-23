// 0.1.9
#include "ccrt.h"

class Mod_main : public NliCCRTBase {
public:
  Mod_main()
 : NliCCRTBase(), result_channel_inst("result"), param_channel_inst("param")  {}

  NliChannel result_channel_inst;
  NliChannel param_channel_inst;
  int state;
  uint64_t r4_main;
  uint64_t reg_t1;
  uint64_t reg_t4;
  uint64_t reg_t6;
  uint64_t reg_t2_v2;
  uint64_t reg_t1_v4;
  uint64_t reg_t1_v5;
  uint64_t reg_t2_v7;
  uint64_t reg_t3_v8;
  uint64_t reg_t3_v9;
  uint64_t r4_main_v13;
  uint64_t reg_t8;
  uint64_t reg_t9;
  void s_3();
  void s_8();
  int st_2_;
  void s_12();
  int st_4_;
  void s_40();
  void s_43();
  void reset();
  void PostState();
  bool Dispatch();
  void DumpState();
};

void Mod_main::s_3() {
  reg_t1_v4 = 0UL;
  reg_t1 = 1UL;
  reg_t3_v9 = 0UL;
  reg_t4 = 0UL;
  reg_t8 = 0UL;
  reg_t9 = 1UL;
  if (true) {
    state = 8;
  }
}

void Mod_main::s_8() {
  bool finish_state = false;
  if (st_2_ == 3) {
    finish_state = true;
  }
  // channel read.
  r4_main_v13 = param_channel_inst.Read();
  if (finish_state) {
    st_2_ = 0;
    state = 40;
  }
}

void Mod_main::s_12() {
  bool finish_state = false;
  if (st_4_ == 3) {
    finish_state = true;
  }
  // channel write.
  result_channel_inst.Write(reg_t6);
  if (finish_state) {
    st_4_ = 0;
    state = 3;
  }
}

void Mod_main::s_40() {
  uint64_t wire_t10;
  uint64_t wire_t11;
  uint64_t wire_t12;
  uint64_t wire_t13;
  wire_t10 = reg_t4 ? reg_t1_v5 : reg_t1_v4;
  wire_t11 = reg_t8 ? reg_t2_v7 : reg_t1;
  wire_t12 = reg_t9 ? reg_t3_v9 : reg_t3_v8;
  wire_t13 = r4_main_v13 > wire_t12;
  reg_t6 = wire_t10;
  reg_t2_v2 = wire_t11;
  r4_main = wire_t12;
  reg_t4 = wire_t13;
  if (true) {
    if (wire_t13) state = 43;
    else
    state = 12;
  }
}

void Mod_main::s_43() {
  uint64_t wire_t14;
  uint64_t wire_t15;
  reg_t1_v5 = reg_t2_v2;
  reg_t4 = 1UL;
  wire_t14 = r4_main + 1UL;
  wire_t15 = reg_t2_v2 + reg_t6;
  reg_t9 = 0UL;
  reg_t8 = 1UL;
  reg_t2_v7 = wire_t15;
  reg_t3_v8 = wire_t14;
  reg_t1_v4 = wire_t15;
  if (true) {
    state = 40;
  }
}

void Mod_main::reset() {
  st_2_ = 0;
  st_4_ = 0;
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
    case 8:
      s_8();
      break;
    case 12:
      s_12();
      break;
    case 40:
      s_40();
      break;
    case 43:
      s_43();
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
