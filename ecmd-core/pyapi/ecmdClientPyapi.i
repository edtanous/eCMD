
%module ecmd
// This kills all the warns generated by use of -keyword for functions
// we know can't be overloaded to use keyword args
#pragma SWIG nowarn=511

// python helper to load _ecmd.so correctly for fapi
%include dlopenhelper.i

/*********** Start Typemaps ***********/
%include typemaps.i
%include pybuffer.i
%include std_string.i
%include std_list.i
%include std_vector.i
%include stdint.i
%include ecmdCommon.i
%include ecmdConst.i
%include std_map.i
/*********** End Typemaps ***********/

/*********** Start Applies ***********/
// These are used to map C types that swig doesn't understand to types swig does understand
#if defined(APPLY_OUTARGS)
%include ecmdApplyOutArgs.i
#endif
/*********** End Applies ***********/

/*********** Start Insert Code ***********/
// Insert C code into the file swig generates
%{
#define SWIG_FILE_WITH_INIT
#define SWIG_PYTHON_EXTRA_NATIVE_CONTAINERS
#include "ecmdDefines.H"
#include "ecmdClientCapi.H"
#include "ecmdClientPyapi.H"
#include "ecmdDataBufferBase.H"
#include "ecmdDataBuffer.H"
#include "ecmdStructs.H"
#include "ecmdUtils.H"
#include "ecmdSharedUtils.H"
// Header file needed to compile with newer gcc
#include <stddef.h>

%}
%include "ecmdExtPyInserts.i"
/*********** End Insert Code ***********/

/*********** Start Templates ***********/
// Templates for list/vector support - one of these have to be created for every type needed
// From ecmdStructs.H
%template(ecmdThreadDataList)        std::list<ecmdThreadData>;
%template(ecmdChipUnitDataList)      std::list<ecmdChipUnitData>;
%template(ecmdChipDataList)          std::list<ecmdChipData>;
%template(ecmdSlotDataList)          std::list<ecmdSlotData>;
%template(ecmdNodeDataList)          std::list<ecmdNodeData>;
%template(ecmdCageDataList)          std::list<ecmdCageData>;
%template(stringList)                std::list<std::string>;
%template(stringVector)              std::vector<std::string>;
%template(ecmdDataBufferBaseVector)  std::vector<ecmdDataBufferBase>;
%template(ecmdDataBufferVector)      std::vector<ecmdDataBuffer>;
%template(ecmdDataBufferVectorVector) std::vector<std::vector<ecmdDataBuffer>>;
%template(ecmdMemoryEntryList)       std::list<ecmdMemoryEntry>;
%template(ecmdRingDataList)          std::list<ecmdRingData>;
%template(ecmdLatchDataList)         std::list<ecmdLatchData>;
%template(ecmdLatchEntryList)        std::list<ecmdLatchEntry>;
%template(ecmdSpyGroupDataList)      std::list<ecmdSpyGroupData>;
%template(ecmdArrayEntryList)        std::list<ecmdArrayEntry>;
%template(ecmdNameEntryList)         std::list<ecmdNameEntry>;
%template(ecmdNameVectorEntryList)   std::list<ecmdNameVectorEntry>;
%template(ecmdIndexEntryList)        std::list<ecmdIndexEntry>;
%template(ecmdChipTargetList)        std::list<ecmdChipTarget>;
%template(ecmdArrayDataList)         std::list<ecmdArrayData>;
%template(ecmdTraceArrayDataList)    std::list<ecmdTraceArrayData>;
%template(ecmdSpyDataList)           std::list<ecmdSpyData>;
%template(ecmdSpyLatchDataList)      std::list<ecmdSpyLatchData>;
%template(ecmdScomDataList)          std::list<ecmdScomData>;
%template(ecmdScomDataHiddenList)    std::list<ecmdScomDataHidden>;
%template(ecmdI2CCmdEntryList)       std::list<ecmdI2CCmdEntry>;
%template(ecmdI2CCmdEntryHiddenList) std::list<ecmdI2CCmdEntryHidden>;
%template(ecmdConnectionDataList)    std::list<ecmdConnectionData>;
%template(ecmdScomEntryList)         std::list<ecmdScomEntry>;
%template(ecmdFileLocationList)      std::list<ecmdFileLocation>;
%template(uint32_tList)              std::list<uint32_t>;
// Template for maps
%template(string_ecmdDataBufferMap)  std::map<std::string, ecmdDataBuffer>;

/*********** Start Copy Constructors ***********/
// We also define __deepcopy__ for each class here since
// they also rely upon the copy constructors we are defining
%copyctor ecmdChipTarget;
%extend ecmdChipTarget {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdChipTarget(self)
%}
}
%copyctor ecmdThreadData;
%extend ecmdThreadData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdThreadData(self)
%}
}
%copyctor ecmdChipUnitData;
%extend ecmdChipUnitData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdChipUnitData(self)
%}
}
%copyctor ecmdChipData;
%extend ecmdChipData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdChipData(self)
%}
}
%copyctor ecmdSlotData;
%extend ecmdSlotData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdSlotData(self)
%}
}
%copyctor ecmdNodeData;
%extend ecmdNodeData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdNodeData(self)
%}
}
%copyctor ecmdCageData;
%extend ecmdCageData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdCageData(self)
%}
}
%copyctor ecmdQueryData;
%extend ecmdQueryData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdQueryData(self)
%}
}
%copyctor ecmdRingData;
%extend ecmdRingData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdRingData(self)
%}
}
%copyctor ecmdArrayData;
%extend ecmdArrayData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdArrayData(self)
%}
}
%copyctor ecmdTraceArrayData;
%extend ecmdTraceArrayData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdTraceArrayData(self)
%}
}
%copyctor ecmdFastArrayData;
%extend ecmdFastArrayData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdFastArrayData(self)
%}
}
%copyctor ecmdScomData;
%extend ecmdScomData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdScomData(self)
%}
}
%copyctor ecmdScomDataHidden;
%extend ecmdScomDataHidden {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdScomDataHidden(self)
%}
}
%copyctor ecmdLataData;
%extend ecmdLatchData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdLataData(self)
%}
}
%copyctor ecmdScomEntry;
%extend ecmdScomEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdScomEntry(self)
%}
}
%copyctor ecmdArrayEntry;
%extend ecmdArrayEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdArrayEntry(self)
%}
}
%copyctor ecmdNameEntry;
%extend ecmdNameEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdNameEntry(self)
%}
}
%copyctor ecmdNameVectorEntry;
%extend ecmdNameVectorEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdNameVectorEntry(self)
%}
}
%copyctor ecmdIndexVectorEntry;
%extend ecmdIndexVectorEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdIndexVectorEntry(self)
%}
}
%copyctor ecmdIndexEntry;
%extend ecmdIndexEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdIndexEntry(self)
%}
}
%copyctor ecmdLatchEntry;
%extend ecmdLatchEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdLatchEntry(self)
%}
}
%copyctor ecmdLatchQueryData;
%extend ecmdLatchQueryData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdLatchQueryData(self)
%}
}
%copyctor ecmdLatchQueryDataHidden;
%extend ecmdLatchQueryDataHidden {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdLatchQueryDataHidden(self)
%}
}
%copyctor ecmdProcRegisterInfo;
%extend ecmdProcRegisterInfo {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdProcRegisterInfo(self)
%}
}
%copyctor ecmdCacheData;
%extend ecmdCacheData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdCacheData(self)
%}
}
%copyctor ecmdSpyData;
%extend ecmdSpyData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdSpyData(self)
%}
}
%copyctor ecmdI2CCmdEntry;
%extend ecmdI2CCmdEntry {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdI2CCmdEntry(self)
%}
}
%copyctor ecmdI2CCmdEntryHidden;
%extend ecmdI2CCmdEntryHidden {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdI2CCmdEntryHidden(self)
%}
}
%copyctor ecmdSimModelInfo;
%extend ecmdSimModelInfo {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdSimModelInfo(self)
%}
}
%copyctor ecmdConnectionData;
%extend ecmdConnectionData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdConnectionData(self)
%}
}
%copyctor ecmdPnorListEntryData;
%extend ecmdPnorListEntryData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdPnorListEntryData(self)
%}
}
%copyctor ecmdPnorListData;
%extend ecmdPnorListData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdPnorListData(self)
%}
}
%copyctor ecmdLooperData;
%extend ecmdLooperData {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdLooperData(self)
%}
}
/*********** End Copy Constructors ***********/

/*********** Start Extend ***********/
// Add a hash function to the ecmdChipTarget
// This allows it to be used as a dict key, etc..
// Use all the values of the ecmdChipTarget in the hash generation for uniqueness
%extend ecmdChipTarget {
%pythoncode %{
def __hash__(self):
    return hash((self.cage, self.cageState, self.node, self.nodeState,
                 self.slot, self.slotState,
                 self.pos, self.posState, self.chipType, self.chipTypeState,
                 self.chipUnitNum, self.chipUnitNumState,
                 self.chipUnitType, self.chipUnitTypeState,
                 self.thread, self.threadState))
%}
}

// Define a __deepcopy__ for the databuffer using its copy constructor
%extend ecmdDataBuffer {
%pythoncode %{
def __deepcopy__(self, memo):
    return ecmdDataBuffer(self)
%}
}
/*********** End Extend ***********/

/*********** Start Map to Bytearray ***********/
// These apply the insert/extract/memCopyIn/memCopyOut functions in the edb
%pybuffer_mutable_string(uint8_t * o_data);
%pybuffer_mutable_string(uint8_t * i_data);
%pybuffer_mutable_string(uint8_t * o_buf);
%pybuffer_mutable_string(uint8_t * i_buf);
/*********** End Map to Bytearray ***********/

/*********** Start Files to swigify ***********/
%include "ecmdDefines.H"
%include "ecmdStructs.H"
%include "ecmdUtils.H"
%include "ecmdSharedUtils.H"
%include "ecmdReturnCodes.H"
%include "ecmdDataBufferBase.H"
%include "ecmdDataBuffer.H"
%include "ecmdClientCapi.H"
%include "ecmdClientPyapi.H"

%include "ecmdExtPyIncludes.i"
/*********** End Files to swigify ***********/
