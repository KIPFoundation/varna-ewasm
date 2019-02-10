(module
 (type $0 (func (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32 i32 i32)))
 (type $3 (func (param i32)))
 (type $4 (func (param i32 i32) (result i32)))
 (type $5 (func (param i32 i32 i32 i32 i32 i32 i32) (result i32)))
 (type $6 (func (param i32 i32 i32 i32) (result i32)))
 (type $7 (func))
 (type $8 (func (param i32) (result i32)))
 (type $9 (func (param i32 i32 i32 i32 i32 i64) (result i32)))
 (import "ethereum" "getCallDataSize" (func $fimport$0 (result i32)))
 (import "ethereum" "revert" (func $fimport$1 (param i32 i32)))
 (import "ethereum" "callDataCopy" (func $fimport$2 (param i32 i32 i32)))
 (import "ethereum" "storageLoad" (func $fimport$3 (param i32 i32)))
 (import "ethereum" "finish" (func $fimport$4 (param i32 i32)))
 (import "ethereum" "getCaller" (func $fimport$5 (param i32)))
 (import "ethereum" "storageStore" (func $fimport$6 (param i32 i32)))
 (import "ethereum" "__syscall1" (func $fimport$7 (param i32 i32) (result i32)))
 (import "ethereum" "__syscall6" (func $fimport$8 (param i32 i32 i32 i32 i32 i32 i32) (result i32)))
 (import "ethereum" "__syscall3" (func $fimport$9 (param i32 i32 i32 i32) (result i32)))
 (global $global$0 (mut i32) (i32.const 66656))
 (global $global$1 i32 (i32.const 66656))
 (global $global$2 i32 (i32.const 1108))
 (table 1 1 anyfunc)
 (memory $0 2)
 (data (i32.const 1024) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (export "memory" (memory $0))
 (export "main" (func $1))
 (func $0 (; 10 ;) (type $7)
  (local $var$0 i32)
  (local $var$1 i32)
  (local $var$2 i32)
  (local $var$3 i64)
  (local $var$4 i32)
  (local $var$5 i32)
  (local $var$6 i64)
  (local $var$7 i64)
  (block $label$1
   (br_if $label$1
    (i32.eq
     (call $fimport$0)
     (i32.const 32)
    )
   )
   (call $fimport$1
    (i32.const 0)
    (i32.const 0)
   )
  )
  (call $fimport$5
   (tee_local $var$0
    (call $4
     (i32.const 32)
    )
   )
  )
  (call $fimport$2
   (tee_local $var$1
    (call $4
     (i32.const 32)
    )
   )
   (i32.const 4)
   (i32.const 20)
  )
  (call $fimport$2
   (tee_local $var$2
    (call $4
     (i32.const 32)
    )
   )
   (i32.const 24)
   (i32.const 8)
  )
  (i64.store
   (get_local $var$2)
   (i64.add
    (i64.or
     (i64.or
      (i64.or
       (i64.or
        (i64.or
         (i64.or
          (i64.and
           (i64.shr_u
            (tee_local $var$3
             (i64.load
              (get_local $var$2)
             )
            )
            (i64.const 40)
           )
           (i64.const 65280)
          )
          (i64.shr_u
           (get_local $var$3)
           (i64.const 56)
          )
         )
         (i64.and
          (i64.shr_u
           (get_local $var$3)
           (i64.const 24)
          )
          (i64.const 16711680)
         )
        )
        (i64.and
         (i64.shr_u
          (get_local $var$3)
          (i64.const 8)
         )
         (i64.const 4278190080)
        )
       )
       (i64.and
        (i64.shl
         (get_local $var$3)
         (i64.const 8)
        )
        (i64.const 1095216660480)
       )
      )
      (i64.and
       (i64.shl
        (get_local $var$3)
        (i64.const 24)
       )
       (i64.const 280375465082880)
      )
     )
     (i64.and
      (i64.shl
       (get_local $var$3)
       (i64.const 40)
      )
      (i64.const 71776119061217280)
     )
    )
    (i64.shl
     (get_local $var$3)
     (i64.const 56)
    )
   )
  )
  (set_local $var$4
   (call $4
    (i32.const 32)
   )
  )
  (call $fimport$3
   (get_local $var$0)
   (tee_local $var$5
    (call $4
     (i32.const 32)
    )
   )
  )
  (call $fimport$3
   (get_local $var$1)
   (get_local $var$4)
  )
  (i64.store
   (get_local $var$5)
   (tee_local $var$6
    (i64.add
     (i64.or
      (i64.or
       (i64.or
        (i64.or
         (i64.or
          (i64.or
           (i64.and
            (i64.shr_u
             (tee_local $var$3
              (i64.load
               (get_local $var$5)
              )
             )
             (i64.const 40)
            )
            (i64.const 65280)
           )
           (i64.shr_u
            (get_local $var$3)
            (i64.const 56)
           )
          )
          (i64.and
           (i64.shr_u
            (get_local $var$3)
            (i64.const 24)
           )
           (i64.const 16711680)
          )
         )
         (i64.and
          (i64.shr_u
           (get_local $var$3)
           (i64.const 8)
          )
          (i64.const 4278190080)
         )
        )
        (i64.and
         (i64.shl
          (get_local $var$3)
          (i64.const 8)
         )
         (i64.const 1095216660480)
        )
       )
       (i64.and
        (i64.shl
         (get_local $var$3)
         (i64.const 24)
        )
        (i64.const 280375465082880)
       )
      )
      (i64.and
       (i64.shl
        (get_local $var$3)
        (i64.const 40)
       )
       (i64.const 71776119061217280)
      )
     )
     (i64.shl
      (get_local $var$3)
      (i64.const 56)
     )
    )
   )
  )
  (i64.store
   (get_local $var$4)
   (tee_local $var$3
    (i64.add
     (i64.or
      (i64.or
       (i64.or
        (i64.or
         (i64.or
          (i64.or
           (i64.and
            (i64.shr_u
             (tee_local $var$3
              (i64.load
               (get_local $var$4)
              )
             )
             (i64.const 40)
            )
            (i64.const 65280)
           )
           (i64.shr_u
            (get_local $var$3)
            (i64.const 56)
           )
          )
          (i64.and
           (i64.shr_u
            (get_local $var$3)
            (i64.const 24)
           )
           (i64.const 16711680)
          )
         )
         (i64.and
          (i64.shr_u
           (get_local $var$3)
           (i64.const 8)
          )
          (i64.const 4278190080)
         )
        )
        (i64.and
         (i64.shl
          (get_local $var$3)
          (i64.const 8)
         )
         (i64.const 1095216660480)
        )
       )
       (i64.and
        (i64.shl
         (get_local $var$3)
         (i64.const 24)
        )
        (i64.const 280375465082880)
       )
      )
      (i64.and
       (i64.shl
        (get_local $var$3)
        (i64.const 40)
       )
       (i64.const 71776119061217280)
      )
     )
     (i64.shl
      (get_local $var$3)
      (i64.const 56)
     )
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i64.ge_u
     (get_local $var$6)
     (tee_local $var$7
      (i64.load
       (get_local $var$2)
      )
     )
    )
   )
   (call $fimport$1
    (i32.const 0)
    (i32.const 0)
   )
   (set_local $var$3
    (i64.load
     (get_local $var$4)
    )
   )
   (set_local $var$6
    (i64.load
     (get_local $var$5)
    )
   )
   (set_local $var$7
    (i64.load
     (get_local $var$2)
    )
   )
  )
  (i64.store
   (get_local $var$4)
   (i64.add
    (i64.or
     (i64.or
      (i64.or
       (i64.or
        (i64.or
         (i64.or
          (i64.and
           (i64.shr_u
            (tee_local $var$3
             (i64.add
              (get_local $var$3)
              (get_local $var$7)
             )
            )
            (i64.const 40)
           )
           (i64.const 65280)
          )
          (i64.shr_u
           (get_local $var$3)
           (i64.const 56)
          )
         )
         (i64.and
          (i64.shr_u
           (get_local $var$3)
           (i64.const 24)
          )
          (i64.const 16711680)
         )
        )
        (i64.and
         (i64.shr_u
          (get_local $var$3)
          (i64.const 8)
         )
         (i64.const 4278190080)
        )
       )
       (i64.and
        (i64.shl
         (get_local $var$3)
         (i64.const 8)
        )
        (i64.const 1095216660480)
       )
      )
      (i64.and
       (i64.shl
        (get_local $var$3)
        (i64.const 24)
       )
       (i64.const 280375465082880)
      )
     )
     (i64.and
      (i64.shl
       (get_local $var$3)
       (i64.const 40)
      )
      (i64.const 71776119061217280)
     )
    )
    (i64.shl
     (get_local $var$3)
     (i64.const 56)
    )
   )
  )
  (i64.store
   (get_local $var$5)
   (i64.add
    (i64.or
     (i64.or
      (i64.or
       (i64.or
        (i64.or
         (i64.or
          (i64.and
           (i64.shr_u
            (tee_local $var$3
             (i64.sub
              (get_local $var$6)
              (get_local $var$7)
             )
            )
            (i64.const 40)
           )
           (i64.const 65280)
          )
          (i64.shr_u
           (get_local $var$3)
           (i64.const 56)
          )
         )
         (i64.and
          (i64.shr_u
           (get_local $var$3)
           (i64.const 24)
          )
          (i64.const 16711680)
         )
        )
        (i64.and
         (i64.shr_u
          (get_local $var$3)
          (i64.const 8)
         )
         (i64.const 4278190080)
        )
       )
       (i64.and
        (i64.shl
         (get_local $var$3)
         (i64.const 8)
        )
        (i64.const 1095216660480)
       )
      )
      (i64.and
       (i64.shl
        (get_local $var$3)
        (i64.const 24)
       )
       (i64.const 280375465082880)
      )
     )
     (i64.and
      (i64.shl
       (get_local $var$3)
       (i64.const 40)
      )
      (i64.const 71776119061217280)
     )
    )
    (i64.shl
     (get_local $var$3)
     (i64.const 56)
    )
   )
  )
  (call $fimport$6
   (get_local $var$0)
   (get_local $var$5)
  )
  (call $fimport$6
   (get_local $var$1)
   (get_local $var$4)
  )
 )
 (func $1 (; 11 ;) (type $7)
  (local $var$0 i32)
  (local $var$1 i32)
  (block $label$1
   (br_if $label$1
    (i32.gt_u
     (call $fimport$0)
     (i32.const 3)
    )
   )
   (call $fimport$1
    (i32.const 0)
    (i32.const 0)
   )
  )
  (call $fimport$2
   (tee_local $var$0
    (call $4
     (i32.const 4)
    )
   )
   (i32.const 0)
   (i32.const 4)
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (tee_local $var$0
       (i32.load
        (get_local $var$0)
       )
      )
      (i32.const -1113639587)
     )
    )
    (br_if $label$2
     (i32.ne
      (get_local $var$0)
      (i32.const 436376473)
     )
    )
    (block $label$4
     (br_if $label$4
      (i32.eq
       (call $fimport$0)
       (i32.const 24)
      )
     )
     (call $fimport$1
      (i32.const 0)
      (i32.const 0)
     )
    )
    (call $fimport$2
     (tee_local $var$0
      (call $4
       (i32.const 32)
      )
     )
     (i32.const 4)
     (i32.const 20)
    )
    (call $fimport$3
     (get_local $var$0)
     (tee_local $var$1
      (call $4
       (i32.const 32)
      )
     )
    )
    (call $fimport$4
     (get_local $var$1)
     (i32.const 32)
    )
    (return)
   )
   (call $0)
   (return)
  )
  (call $fimport$1
   (i32.const 0)
   (i32.const 0)
  )
 )
 (func $2 (; 12 ;) (type $0) (result i32)
  (i32.const 31)
 )
 (func $3 (; 13 ;) (type $8) (param $var$0 i32) (result i32)
  (local $var$1 i32)
  (local $var$2 i32)
  (local $var$3 i32)
  (local $var$4 i32)
  (local $var$5 i32)
  (local $var$6 i32)
  (set_global $global$0
   (tee_local $var$1
    (i32.sub
     (get_global $global$0)
     (i32.const 16)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.lt_u
     (tee_local $var$2
      (i32.load
       (get_local $var$0)
      )
     )
     (i32.const 2147418112)
    )
   )
   (i32.store
    (call $2)
    (i32.const 12)
   )
   (set_global $global$0
    (i32.add
     (get_local $var$1)
     (i32.const 16)
    )
   )
   (return
    (i32.const 0)
   )
  )
  (set_local $var$2
   (i32.add
    (i32.and
     (i32.sub
      (i32.const 0)
      (get_local $var$2)
     )
     (i32.const 65535)
    )
    (get_local $var$2)
   )
  )
  (block $label$2
   (block $label$3
    (block $label$4
     (br_if $label$4
      (i32.eqz
       (tee_local $var$3
        (i32.load offset=1088
         (i32.const 0)
        )
       )
      )
     )
     (set_local $var$4
      (i32.const -1)
     )
     (br_if $label$3
      (i32.lt_u
       (get_local $var$2)
       (i32.xor
        (get_local $var$3)
        (i32.const -1)
       )
      )
     )
     (br $label$2)
    )
    (i32.store offset=1088
     (i32.const 0)
     (tee_local $var$3
      (i32.add
       (i32.and
        (i32.sub
         (i32.const 0)
         (tee_local $var$3
          (call $fimport$7
           (i32.const 45)
           (i32.const 0)
          )
         )
        )
        (i32.const 65535)
       )
       (get_local $var$3)
      )
     )
    )
    (set_local $var$4
     (i32.const -1)
    )
    (br_if $label$2
     (i32.ge_u
      (get_local $var$2)
      (i32.xor
       (get_local $var$3)
       (i32.const -1)
      )
     )
    )
   )
   (i32.store offset=12
    (get_local $var$1)
    (tee_local $var$5
     (i32.load offset=1040
      (i32.const 0)
     )
    )
   )
   (set_local $var$6
    (i32.add
     (get_local $var$3)
     (get_local $var$2)
    )
   )
   (block $label$5
    (br_if $label$5
     (i32.le_u
      (get_local $var$5)
      (get_local $var$3)
     )
    )
    (br_if $label$2
     (i32.lt_u
      (select
       (i32.add
        (get_local $var$5)
        (i32.const -8388608)
       )
       (i32.const 0)
       (i32.gt_u
        (get_local $var$5)
        (i32.const 8388608)
       )
      )
      (get_local $var$6)
     )
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.ge_u
      (get_local $var$3)
      (i32.add
       (get_local $var$1)
       (i32.const 12)
      )
     )
    )
    (br_if $label$2
     (i32.lt_u
      (select
       (i32.add
        (i32.add
         (get_local $var$1)
         (i32.const 12)
        )
        (i32.const -8388608)
       )
       (i32.const 0)
       (i32.gt_u
        (i32.add
         (get_local $var$1)
         (i32.const 12)
        )
        (i32.const 8388608)
       )
      )
      (get_local $var$6)
     )
    )
   )
   (br_if $label$2
    (i32.ne
     (tee_local $var$3
      (call $fimport$7
       (i32.const 45)
       (get_local $var$6)
      )
     )
     (i32.add
      (tee_local $var$5
       (i32.load offset=1088
        (i32.const 0)
       )
      )
      (get_local $var$2)
     )
    )
   )
   (i32.store
    (get_local $var$0)
    (get_local $var$2)
   )
   (i32.store offset=1088
    (i32.const 0)
    (get_local $var$3)
   )
   (set_global $global$0
    (i32.add
     (get_local $var$1)
     (i32.const 16)
    )
   )
   (return
    (get_local $var$5)
   )
  )
  (set_local $var$3
   (i32.const 0)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (tee_local $var$5
      (call $7
       (i32.const 0)
       (tee_local $var$2
        (select
         (tee_local $var$5
          (i32.shl
           (i32.const 65536)
           (i32.shr_u
            (i32.load offset=1092
             (i32.const 0)
            )
            (i32.const 1)
           )
          )
         )
         (get_local $var$2)
         (i32.lt_u
          (get_local $var$2)
          (get_local $var$5)
         )
        )
       )
       (i32.const 3)
       (i32.const 34)
       (get_local $var$4)
       (i64.const 0)
      )
     )
     (get_local $var$4)
    )
   )
   (i32.store
    (get_local $var$0)
    (get_local $var$2)
   )
   (i32.store offset=1092
    (i32.const 0)
    (i32.add
     (i32.load offset=1092
      (i32.const 0)
     )
     (i32.const 1)
    )
   )
   (set_local $var$3
    (get_local $var$5)
   )
  )
  (set_global $global$0
   (i32.add
    (get_local $var$1)
    (i32.const 16)
   )
  )
  (get_local $var$3)
 )
 (func $4 (; 14 ;) (type $8) (param $var$0 i32) (result i32)
  (local $var$1 i32)
  (local $var$2 i32)
  (local $var$3 i32)
  (local $var$4 i32)
  (set_global $global$0
   (tee_local $var$1
    (i32.sub
     (get_global $global$0)
     (i32.const 16)
    )
   )
  )
  (set_local $var$2
   (select
    (get_local $var$0)
    (i32.const 1)
    (get_local $var$0)
   )
  )
  (set_local $var$3
   (i32.const 1)
  )
  (block $label$1
   (loop $label$2
    (br_if $label$1
     (i32.ge_u
      (tee_local $var$0
       (get_local $var$3)
      )
      (get_local $var$2)
     )
    )
    (set_local $var$3
     (i32.shl
      (get_local $var$0)
      (i32.const 1)
     )
    )
    (br_if $label$2
     (i32.lt_u
      (get_local $var$0)
      (i32.const 16)
     )
    )
   )
  )
  (call $8
   (i32.const 1104)
  )
  (block $label$3
   (br_if $label$3
    (i32.le_u
     (tee_local $var$3
      (i32.add
       (select
        (tee_local $var$4
         (i32.and
          (i32.add
           (get_local $var$0)
           (i32.const -1)
          )
          (i32.sub
           (i32.const 0)
           (tee_local $var$0
            (i32.load offset=1096
             (i32.const 0)
            )
           )
          )
         )
        )
        (i32.const 0)
        (i32.lt_u
         (get_local $var$2)
         (i32.const -2147483632)
        )
       )
       (get_local $var$2)
      )
     )
     (i32.sub
      (i32.load offset=1100
       (i32.const 0)
      )
      (get_local $var$0)
     )
    )
   )
   (i32.store offset=12
    (get_local $var$1)
    (get_local $var$3)
   )
   (block $label$4
    (block $label$5
     (block $label$6
      (br_if $label$6
       (i32.eqz
        (tee_local $var$2
         (call $3
          (i32.add
           (get_local $var$1)
           (i32.const 12)
          )
         )
        )
       )
      )
      (br_if $label$5
       (i32.eq
        (get_local $var$2)
        (i32.load offset=1100
         (i32.const 0)
        )
       )
      )
      (i32.store offset=1096
       (i32.const 0)
       (get_local $var$2)
      )
      (set_local $var$3
       (i32.sub
        (get_local $var$3)
        (get_local $var$4)
       )
      )
      (set_local $var$0
       (get_local $var$2)
      )
      (set_local $var$4
       (i32.const 0)
      )
      (br $label$4)
     )
     (call $9
      (i32.const 1104)
     )
     (set_global $global$0
      (i32.add
       (get_local $var$1)
       (i32.const 16)
      )
     )
     (return
      (i32.const 0)
     )
    )
    (set_local $var$0
     (i32.load offset=1096
      (i32.const 0)
     )
    )
   )
   (i32.store offset=1100
    (i32.const 0)
    (i32.add
     (get_local $var$2)
     (i32.load offset=12
      (get_local $var$1)
     )
    )
   )
  )
  (i32.store offset=1096
   (i32.const 0)
   (i32.add
    (get_local $var$0)
    (get_local $var$3)
   )
  )
  (call $9
   (i32.const 1104)
  )
  (set_global $global$0
   (i32.add
    (get_local $var$1)
    (i32.const 16)
   )
  )
  (i32.add
   (get_local $var$0)
   (get_local $var$4)
  )
 )
 (func $5 (; 15 ;) (type $8) (param $var$0 i32) (result i32)
  (block $label$1
   (br_if $label$1
    (i32.lt_u
     (get_local $var$0)
     (i32.const -4095)
    )
   )
   (i32.store
    (call $2)
    (i32.sub
     (i32.const 0)
     (get_local $var$0)
    )
   )
   (set_local $var$0
    (i32.const -1)
   )
  )
  (get_local $var$0)
 )
 (func $6 (; 16 ;) (type $7)
 )
 (func $7 (; 17 ;) (type $9) (param $var$0 i32) (param $var$1 i32) (param $var$2 i32) (param $var$3 i32) (param $var$4 i32) (param $var$5 i64) (result i32)
  (block $label$1
   (br_if $label$1
    (i64.eqz
     (i64.and
      (get_local $var$5)
      (i64.const -17592186040321)
     )
    )
   )
   (i32.store
    (call $2)
    (i32.const 22)
   )
   (return
    (i32.const -1)
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.lt_u
     (get_local $var$1)
     (i32.const 2147483647)
    )
   )
   (i32.store
    (call $2)
    (i32.const 12)
   )
   (return
    (i32.const -1)
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.eqz
     (i32.and
      (get_local $var$3)
      (i32.const 16)
     )
    )
   )
   (call $6)
  )
  (set_local $var$1
   (call $fimport$8
    (i32.const 192)
    (get_local $var$0)
    (get_local $var$1)
    (get_local $var$2)
    (get_local $var$3)
    (get_local $var$4)
    (i32.wrap/i64
     (i64.shr_u
      (get_local $var$5)
      (i64.const 12)
     )
    )
   )
  )
  (block $label$4
   (br_if $label$4
    (get_local $var$0)
   )
   (br_if $label$4
    (i32.ne
     (get_local $var$1)
     (i32.const -1)
    )
   )
   (set_local $var$1
    (select
     (i32.const -12)
     (i32.const -1)
     (i32.eq
      (i32.and
       (get_local $var$3)
       (i32.const 48)
      )
      (i32.const 32)
     )
    )
   )
  )
  (call $5
   (get_local $var$1)
  )
 )
 (func $8 (; 18 ;) (type $3) (param $var$0 i32)
  (local $var$1 i32)
  (local $var$2 i32)
  (local $var$3 i32)
  (block $label$1
   (br_if $label$1
    (i32.eqz
     (i32.load offset=1036
      (i32.const 0)
     )
    )
   )
   (block $label$2
    (block $label$3
     (block $label$4
      (br_if $label$4
       (i32.eqz
        (tee_local $var$1
         (i32.load
          (get_local $var$0)
         )
        )
       )
      )
      (block $label$5
       (br_if $label$5
        (i32.eq
         (tee_local $var$2
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$1)
            (i32.const 2147483647)
           )
           (get_local $var$1)
           (i32.lt_s
            (get_local $var$1)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$3
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$2)
            (i32.const 2147483647)
           )
           (get_local $var$2)
           (i32.lt_s
            (get_local $var$2)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$2
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$3)
            (i32.const 2147483647)
           )
           (get_local $var$3)
           (i32.lt_s
            (get_local $var$3)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$3
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$2)
            (i32.const 2147483647)
           )
           (get_local $var$2)
           (i32.lt_s
            (get_local $var$2)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$2
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$3)
            (i32.const 2147483647)
           )
           (get_local $var$3)
           (i32.lt_s
            (get_local $var$3)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$3
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$2)
            (i32.const 2147483647)
           )
           (get_local $var$2)
           (i32.lt_s
            (get_local $var$2)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$2
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$3)
            (i32.const 2147483647)
           )
           (get_local $var$3)
           (i32.lt_s
            (get_local $var$3)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$3
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$2)
            (i32.const 2147483647)
           )
           (get_local $var$2)
           (i32.lt_s
            (get_local $var$2)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$5
        (i32.eq
         (tee_local $var$2
          (i32.load
           (get_local $var$0)
          )
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$3)
            (i32.const 2147483647)
           )
           (get_local $var$3)
           (i32.lt_s
            (get_local $var$3)
            (i32.const 0)
           )
          )
         )
        )
       )
       (br_if $label$3
        (i32.ne
         (i32.load
          (get_local $var$0)
         )
         (tee_local $var$1
          (select
           (i32.add
            (get_local $var$2)
            (i32.const 2147483647)
           )
           (get_local $var$2)
           (i32.lt_s
            (get_local $var$2)
            (i32.const 0)
           )
          )
         )
        )
       )
      )
      (set_local $var$1
       (i32.add
        (get_local $var$1)
        (i32.const -2147483647)
       )
      )
      (br $label$2)
     )
     (set_local $var$1
      (i32.const -2147483647)
     )
     (br $label$2)
    )
    (loop $label$6
     (br_if $label$6
      (i32.ne
       (tee_local $var$1
        (i32.load
         (get_local $var$0)
        )
       )
       (i32.load
        (get_local $var$0)
       )
      )
     )
    )
    (i32.store
     (get_local $var$0)
     (tee_local $var$1
      (i32.add
       (get_local $var$1)
       (i32.const 1)
      )
     )
    )
    (block $label$7
     (loop $label$8
      (block $label$9
       (br_if $label$9
        (i32.le_s
         (get_local $var$1)
         (i32.const -1)
        )
       )
       (br_if $label$8
        (i32.ne
         (tee_local $var$2
          (get_local $var$1)
         )
         (tee_local $var$1
          (i32.load
           (get_local $var$0)
          )
         )
        )
       )
       (br $label$7)
      )
      (block $label$10
       (br_if $label$10
        (i32.ne
         (call $fimport$9
          (i32.const 240)
          (get_local $var$0)
          (i32.const 128)
          (get_local $var$1)
         )
         (i32.const -38)
        )
       )
       (drop
        (call $fimport$9
         (i32.const 240)
         (get_local $var$0)
         (i32.const 0)
         (get_local $var$1)
        )
       )
      )
      (br_if $label$8
       (i32.ne
        (tee_local $var$2
         (i32.add
          (get_local $var$1)
          (i32.const 2147483647)
         )
        )
        (tee_local $var$1
         (i32.load
          (get_local $var$0)
         )
        )
       )
      )
     )
    )
    (set_local $var$1
     (i32.or
      (get_local $var$2)
      (i32.const -2147483648)
     )
    )
   )
   (i32.store
    (get_local $var$0)
    (get_local $var$1)
   )
  )
 )
 (func $9 (; 19 ;) (type $3) (param $var$0 i32)
  (local $var$1 i32)
  (block $label$1
   (br_if $label$1
    (i32.gt_s
     (i32.load
      (get_local $var$0)
     )
     (i32.const -1)
    )
   )
   (loop $label$2
    (br_if $label$2
     (i32.ne
      (tee_local $var$1
       (i32.load
        (get_local $var$0)
       )
      )
      (i32.load
       (get_local $var$0)
      )
     )
    )
   )
   (i32.store
    (get_local $var$0)
    (i32.add
     (get_local $var$1)
     (i32.const 2147483647)
    )
   )
   (br_if $label$1
    (i32.eq
     (get_local $var$1)
     (i32.const -2147483647)
    )
   )
   (br_if $label$1
    (i32.ne
     (call $fimport$9
      (i32.const 240)
      (get_local $var$0)
      (i32.const 129)
      (i32.const 1)
     )
     (i32.const -38)
    )
   )
   (drop
    (call $fimport$9
     (i32.const 240)
     (get_local $var$0)
     (i32.const 1)
     (i32.const 1)
    )
   )
  )
 )
)

