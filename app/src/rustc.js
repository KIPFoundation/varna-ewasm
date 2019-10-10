const {
    rustcCmd,
    //  extension for wasmGC and wasmdis
    wasmGCCmd,
    wasmdisCmd,
    tempDir,
    wasmBindgenCmd,
    wasmBindgenDeps,
  } = require("../config.js");
  const { exec, joinCmd, exists, writeFile, readFile, unlink} = require("./common.js");
  const fs = require("fs");
  const gcWasm = 'CompiledWasm.wasm';
  const wasmDis = 'wasmDisFile.wat';
  
  //  extension for wasmGC 
  async function wasmGC(wasmFile) {
    if (!await exists(wasmFile)) {
      throw new Error("Wasm file is not found")
    }
    try{
      let InputFileName = tempDir + '/' + "wasmGCFile" + ".wasm";
      console.log(InputFileName);
      await writeFile(InputFileName, wasmFile);
      await exec(joinCmd([wasmGCCmd, InputFileName, '-o', gcWasm]));
      console.log("Optimised Wasm File Name: " + gcWasm);
      return gcWasm;
    } catch(e){
      return e.message;
    }
  }
  
  
  //  extension for wasmdis
  async function wasmdis(optimizedWasmFile) {
    if (!fs.existsSync(optimizedWasmFile)) {
      throw new Error("Wat file is not found")
    }
    try {
    await exec(joinCmd([wasmdisCmd, optimizedWasmFile, '-o', wasmDis]));  
    console.log("Wasmdis File Name: " + wasmDis);
    } catch(e){
      return e.message;
    }
    let wasmDisFileContent;
    wasmDisFileContent = fs.readFileSync(wasmDis, 'utf8');
    return wasmDisFileContent;
  }
  
  async function rustc(source, options = {}) {
    let crateName = 'rustc_h_' + Math.random().toString(36).slice(2);
    let baseName = tempDir + '/' + crateName;
    let rustFile = baseName + '.rs';
    let wasmFile = baseName + '.wasm';
    await writeFile(rustFile, source);
    await writeFile('./abc.rs', source);
  
    try {
      let args = [rustcCmd, rustFile];
      args.push('--target=wasm32-unknown-unknown');
      args.push('--crate-type=cdylib');
      if (options.lto)
        args.push('-Clto');
      if (options.debug)
        args.push('-g');
      switch (options.opt_level) {
        case 's':
        case 'z':
        case '0':
        case '1':
        case '2':
        case '2':
          args.push('-Copt-level=' + options.opt_level);
          break;
      }
      args.push('-o');
      args.push(wasmFile);
      for (let i = 0; i < wasmBindgenDeps.length; i++) {
        args.push('-L');
        args.push(wasmBindgenDeps[i]);
      }
      let output;
      let success = false;
      let opts = {
        // env vars needed for #[wasm_bindgen]
        env: {
          CARGO_PKG_NAME: 'main',
          CARGO_PKG_VERSION: '1.0.0',
        },
      };
      try {
        output = await exec(joinCmd(args), opts);  
        success = true;
      } catch(e) {
        output = 'error: ' + e;
      }
      try {
        if (!success)
          return { success, message: "", console: output };
        let wasm = await readFile(wasmFile);
        let ret = { success, message: output };
        
        // extension for wasmGC and wasmdis
        await writeFile('./in.wasm', wasm);
        let wasmGCFile = await wasmGC(wasm);  
        let wasmDisFile = await wasmdis(wasmGCFile);
        ret.output = wasmDisFile;      
        return ret;
      }
        finally {
        if (success)
          await unlink(wasmFile);
          
      }
    } finally {
      await unlink(rustFile);
    }
  };
  
  module.exports = function(source, options, callback) {
    rustc(source, options)
      .then(result => callback(null, result))
      .catch(err => callback(err, null));
  };
  
  