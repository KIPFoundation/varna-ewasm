const onServer = !!process.env["DYNO"];
const homeDir = process.env["HOME"];
const wasmceptionDir = process.env["WASMCEPTION"] ||
    (__dirname + '/../wasmception');

exports.sysroot = onServer ?
  homeDir + '/sysroot' :
  wasmceptionDir + '/sysroot';

exports.llvmDir = onServer ?
  homeDir + '/clang' :
  wasmceptionDir + '/dist';


//  extension command for wasmGC and chisel and wasmdis

exports.wasmGCCmd = homeDir + '/.cargo/bin/wasm-gc';

exports.chiselCmd = homeDir + '/.cargo/bin/chisel';

exports.wasmdisCmd = homeDir + '/binaryen-1.37.35/bin/wasm-dis';

exports.tempDir = "/tmp";

