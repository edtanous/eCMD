// IBM_PROLOG_BEGIN_TAG 
/* 
 * Copyright 2017 IBM International Business Machines Corp.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * 	http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
// IBM_PROLOG_END_TAG 
/**
 *  @file hwp_executor.H
 *
 *  @brief Defines the FAPI HWP Executor Macro.
 *
 *  The HWP Executor macro is called when a PLAT invoker function or a HWP wants
 *  to execute a HWP. Each platform can modify the macro to do any platform
 *  specific work to execute the HWP (e.g. dlopening a shared library)
 */

/*
 * Change Log ******************************************************************
 * Flag     Defect/Feature  User        Date        Description
 * ------   --------------  ----------  ----------- ----------------------------
 *                          mjjones     06/09/2011  Created.
 */

#ifndef FAPI2PLATHWPEXECUTOR_H_
#define FAPI2PLATHWPEXECUTOR_H_

/**
 * @brief HWP Executor macro
 *
 * By default, this macro just calls the HWP directly. If this cannot be done
 * then the platform needs to modify
 */

#include <return_code.H>
#include <target.H>
#include <string>



// Macro to execute an arbitrary function with an arbitray number of arguments. The
// function is in a shared lib that must be dlopened. All that is required is that
// there is a typedef for the function pointer available that is called <FUNC>_FP_t
// i.e. if the function is called foo, then the typedef is called foo_FP_t
#define FAPI_PLAT_EXEC_HWP(RC, FUNC, _args_...) \
{\
    void * l_pLibHandle = NULL; \
    void * l_pSymAddr = NULL; \
    uint32_t l_u32_rc_xyzabc = ECMD_SUCCESS; \
    l_u32_rc_xyzabc = fapi2plat::openSharedLib(#FUNC, l_pLibHandle); \
    if (l_u32_rc_xyzabc == 0) \
    { \
        l_u32_rc_xyzabc = fapi2plat::getSymAddr(#FUNC, l_pLibHandle, l_pSymAddr); \
        if (l_u32_rc_xyzabc == 0) \
        { \
            FUNC##_FP_t l_pFunc = reinterpret_cast<FUNC##_FP_t> (l_pSymAddr); \
            RC = l_pFunc(_args_); \
        } \
	else \
	{ \
          RC = (fapi2::ReturnCodes) l_u32_rc_xyzabc; \
	} \
        fapi2plat::closeSharedLib(l_pLibHandle); \
    } \
    else \
    { \
      RC = (fapi2::ReturnCodes) l_u32_rc_xyzabc; \
    } \
}

#define FAPI_PLAT_EXEC_HWP_LAMBDA(FUNC, _args_...) \
[&]()->fapi2::ReturnCode \
{\
    void * l_pLibHandle = NULL; \
    void * l_pSymAddr = NULL; \
    uint32_t l_u32_rc_xyzabc = ECMD_SUCCESS; \
    fapi2::ReturnCode rc; \
    l_u32_rc_xyzabc = fapi2plat::openSharedLib(#FUNC, l_pLibHandle); \
    if (l_u32_rc_xyzabc == 0) \
    { \
        l_u32_rc_xyzabc = fapi2plat::getSymAddr(#FUNC, l_pLibHandle, l_pSymAddr); \
        if (l_u32_rc_xyzabc == 0) \
        { \
            FUNC##_FP_t l_pFunc = reinterpret_cast<FUNC##_FP_t> (l_pSymAddr); \
            rc = l_pFunc(_args_); \
        } \
	else \
	{ \
          rc = (fapi2::ReturnCodes) l_u32_rc_xyzabc; \
	} \
        fapi2plat::closeSharedLib(l_pLibHandle); \
    } \
    else \
    { \
      rc = (fapi2::ReturnCodes) l_u32_rc_xyzabc; \
    } \
    return rc;\
}()

namespace fapi2plat
{
    int openSharedLib(const std::string & i_libName, void * & o_pLibHandle, int flag);
    int openSharedLib(const std::string & i_libName, void * & o_pLibHandle);
    int getSymAddr(const char * i_pFuncName, void * i_pLibHandle, void * & o_pSymAddr);
    void closeSharedLib(void * i_pLibHandle);
}



#endif // FAPI2PLATHWPEXECUTOR_H_
