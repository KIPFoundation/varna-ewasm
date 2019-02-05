typedef unsigned char uint8_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;
typedef uint8_t* bytes; 
typedef uint8_t bytes32[32];
typedef uint8_t address[20]; 
typedef unsigned __int128 u128;
typedef uint32_t i32; 
typedef uint32_t i32ptr;
typedef uint64_t i64;
extern "C" {void useGas(i64 amount);
void getCaller(i32ptr* resultOffset);
i32 getCallDataSize();
void callDataCopy(i32ptr* resultOffset, i32 dataOffset, i32 length);
void revert(i32ptr* dataOffset, i32 dataLength);
void finish(i32ptr* dataOffset, i32 dataLength);void storageStore(i32ptr* pathOffset, i32ptr* resultOffset);void storageLoad(i32ptr* pathOffset, i32ptr* resultOffset);
void printMemHex(i32ptr* offset, i32 length);void printStorageHex(i32ptr* key);
}
i64 reverse_bytes(i64 a){
i64 b = 0;
b += (a & 0xff00000000000000)>>56;b += (a & 0x00ff000000000000)>>40;b += (a & 0x0000ff0000000000)>>24;b += (a & 0x000000ff00000000)>>8;b += (a & 0x00000000ff000000)<<8;b += (a & 0x0000000000ff0000)<<24;b += (a & 0x000000000000ff00)<<40;b += (a & 0x00000000000000ff)<<56;return b;}
bytes32 addy[1] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
bytes32 balance[1] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
void do_balance() {if (getCallDataSize() != 24)revert(0, 0);
 callDataCopy((i32ptr*)addy, 4, 20);storageLoad((i32ptr*)addy, (i32ptr*)balance);finish((i32ptr*)balance, 32);}
bytes32 sender[1] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};bytes32 recipient[1] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};bytes32 value[1] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};bytes32 recipient_balance[1] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};bytes32 sender_balance[1] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
 void do_transfer() {if (getCallDataSize() != 32)revert(0, 0);getCaller((i32ptr*)sender);callDataCopy((i32ptr*)recipient, 4, 20);callDataCopy((i32ptr*)value, 24, 8);
 *(i64*)value = reverse_bytes(*(i64*)value);
storageLoad((i32ptr*)sender, (i32ptr*)sender_balance);storageLoad((i32ptr*)recipient, (i32ptr*)recipient_balance);*(i64*)sender_balance = reverse_bytes(*(i64*)sender_balance);*(i64*)recipient_balance = reverse_bytes(*(i64*)recipient_balance);if (*(i64*)sender_balance < *(i64*)value)revert(0, 0); * (i64*)sender_balance -= * (i64*)value;* (i64*)recipient_balance += * (i64*)value;*(i64*)sender_balance = reverse_bytes(*(i64*)sender_balance);*(i64*)recipient_balance = reverse_bytes(*(i64*)recipient_balance);storageStore((i32ptr*)sender, (i32ptr*)sender_balance);storageStore((i32ptr*)recipient, (i32ptr*)recipient_balance);}
i32 selector[1] = {0};
extern "C" {void _main(void);}void _main(void) {if (getCallDataSize() < 4) revert(0, 0);
callDataCopy((i32ptr*)selector, 0, 4); 
switch (*selector) {case 0x1a029399:do_balance();break;case 0xbd9f355d:do_transfer();break;default:revert(0, 0);}}