(module
 (type $0 (func (param i32 i32)))
 (type $1 (func))
 (import "ethereum" "finish" (func $ethereum_finish (param i32 i32)))
 (global $global$0 i32 (i32.const 1048581))
 (global $global$1 i32 (i32.const 1048581))
 (table 1 1 anyfunc)
 (memory $0 17)
 (data (i32.const 1048576) "hello")
 (export "memory" (memory $0))
 (export "main" (func $main))
 (func $main (; 1 ;) (type $1)
  (local $var$0 i32)
  (local $var$1 i32)
  (local $var$2 i32)
  (set_local $var$0
   (i32.const 1048576)
  )
  (set_local $var$1
   (get_local $var$0)
  )
  (set_local $var$2
   (i32.const 5)
  )
  (call $ewasm_api::finish_data::h501ee2225ff4aed2
   (get_local $var$1)
   (get_local $var$2)
  )
  (unreachable)
 )
 (func $ewasm_api::finish_data::h501ee2225ff4aed2 (; 2 ;) (type $0) (param $var$0 i32) (param $var$1 i32)
  (call $ethereum_finish
   (get_local $var$0)
   (get_local $var$1)
  )
  (unreachable)
 )
 ;; custom section "producers", size 71
)

