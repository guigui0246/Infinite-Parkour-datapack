# this file is used for accessing jumppacks with macros
/fetch
  $data modify storage infinite_parkour:jumppack jumppack set from storage jumppack:$(jumppack_id) jumppack
/store
  $data modify storage jumppack:$(jumppack_id) jumppack set from storage infinite_parkour:jumppack jumppack
/delete
  $data remove storage jumppack:$(jumppack_id) jumppack
/get_jump
  $data modify storage infinite_parkour:calc jump set from storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][$(col)]
/set_jump
  $execute unless data storage jumppack:$(jumppack_id) jumppack run data modify storage jumppack:$(jumppack_id) jumppack set value {jumps:[]}
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)] run data modify storage jumppack:$(jumppack_id) jumppack.jumps set value [[],[],[],[],[],[],[],[]]
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)] run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)] set value [[],[],[],[],[],[]]
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][$(col)] run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)] set value [{},{},{},{},{}]
  $data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][$(col)] set from storage infinite_parkour:calc jump
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][].blocks run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)] set value []
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][][].blocks run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)] set value []
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[][][].blocks run data modify storage jumppack:$(jumppack_id) jumppack.jumps set value []

/test_random_jump
  function infinite_parkour:jumppack/fetch {jumppack_id:"my_jumppack"}
  function infinite_parkour:jumppack/random_jump
  data remove storage infinite_parkour:jumppack jumppack

/test_0
  return 0

/test_1
  return 1

# this function should be called after calling infinite_parkour:jumppack/fetch
# the result is in {storage infinite_parkour:jumppack jump}
/random_jump
  scoreboard players set #selecting math 0
  function infinite_parkour:jumppack/random_jump/total_pack

  scoreboard players remove #selecting math 1
  execute store result storage infinite_parkour:macro data.count int 1 run scoreboard players get #selecting math
  execute if score #selecting math matches 1..
    $random value 0..$(count)
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  
  function infinite_parkour:jumppack/random_jump/pick_pack

  scoreboard players reset #selecting math
  data remove storage infinite_parkour:jumppack temp

  /total_pack
    execute unless data storage infinite_parkour:jumppack jumppack.jumps[0] run return 0
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[0]
    function infinite_parkour:jumppack/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[1]
    function infinite_parkour:jumppack/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[2]
    function infinite_parkour:jumppack/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[3]
    function infinite_parkour:jumppack/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[4]
    function infinite_parkour:jumppack/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[5]
    function infinite_parkour:jumppack/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[6]
    function infinite_parkour:jumppack/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[7]
  /total_page
    execute unless data storage infinite_parkour:jumppack temp.page[0] run return 0
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[0]
    function infinite_parkour:jumppack/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[1]
    function infinite_parkour:jumppack/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[2]
    function infinite_parkour:jumppack/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[3]
    function infinite_parkour:jumppack/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[4]
    function infinite_parkour:jumppack/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[5]
  /total_row
    execute unless data storage infinite_parkour:jumppack temp.row[0] run return 0
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[0]
    function infinite_parkour:jumppack/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[1]
    function infinite_parkour:jumppack/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[2]
    function infinite_parkour:jumppack/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[3]
    function infinite_parkour:jumppack/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[4]
    function infinite_parkour:jumppack/random_jump/total_block
  /total_block
    execute unless data storage infinite_parkour:jumppack temp.jump.blocks run return 0
    # TODO change to the weight of the block
    scoreboard players add #selecting math 1

  /pick_pack
    execute unless data storage infinite_parkour:jumppack jumppack.jumps[0] run return 0
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[0]
    execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[1]
    execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[2]
    execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[3]
    execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[4]
    execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[5]
    execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[6]
    execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[7]
    return 0
  /pick_page
    execute unless data storage infinite_parkour:jumppack temp.page[0] run return 0
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[0]
    execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[1]
    execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[2]
    execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[3]
    execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[4]
    execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[5]
    return 0
  /pick_row
    execute unless data storage infinite_parkour:jumppack temp.row[0] run return 0
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[0]
    execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[1]
    execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[2]
    execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[3]
    execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[4]
    execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
    return 0
  /pick_block
    execute unless data storage infinite_parkour:jumppack temp.jump.blocks run return 0
    # TODO change to the weight of the block
    scoreboard players remove #selecting math 1
    execute if score #selecting math matches 0.. run return 0
    data modify storage infinite_parkour:jumppack jump set from storage infinite_parkour:jumppack temp.jump
    return 1