#!/bin/bash
# declare -A paths
# paths=( ["PATH_TO_YAMLS"]="A1" ["PATH_TO_VARS"]="B1" )

# echo "${!paths[@]}"

# a=A
# A=B
# declare -A test=( ['a']='b' )
# declare -n z=test[a]

# test[a]=change

# echo $z

split () {
  ### 3 arguments needed - $1 = string; $2 = delimiter string; $3 = name of the predeclared variable ###
  ### function returns array of sliced strings ###
  if [ -z $3 ]; then
    echo -e '!!!!!ERROR!!!!!\nERROR: 3 string needed:\n $1 = string to be sliced;\n $2 = delimiter string;\n $3 = name of the predeclared variable which will hold result of this function\n!!!!!ERROR!!!!!'
    exit 1;
  fi

  local -n split_result=$3
  split_result=()

  for dir in $(echo $1 | tr $2 " "); do
    split_result+=($dir)
  done

  return 0
}

join () {
  ### 2 arguments needed - $1 = array name $2 = name of the predeclared variable which will hold result of this function ###
  ### 1 argument optional - $3 = delimiter string (it will be added beetween) ###
  if [ -z $2 ]; then
    echo -e '!!!!!ERROR!!!!!\nERROR: 2 string needed:\n $1 = array NAME to be joined;\n $2 = name of the predeclared variable which will hold result of this function\n(OPTIONAL: $3 = delimiter;\n!!!!!ERROR!!!!!'
    exit 1;
  fi

  local -n array=$1
  declare -n join_result=$2
  join_result=""
  delimiter=$3

  for str in ${array[@]}; do
    join_result+="$str$delimiter"
  done

  echo $join_result
  join_result=${join_result::-1}
}
# split $PWD / result
# join result string /
# echo ${result[@]}
# echo $string
# echo ${#result[@]}
# declare -n n=${#result}
# n=${#result}
# echo $n
# a=$(( n-1 ))
# echo $a
# # var=$(echo ${#result}
# declare var=${#result}
# var=$(( ${#result[@]}-2 ))
# str=${result[$var]}
# echo $str
# echo ${result[@]/${result[$(( ${#result[@]}-2 ))]}}

path_prettifier () {
  ### function to cut out any "../" and "./" and transform path accordingly ###
  ### 3 args needed: $1 = path prefix (e.g. $PWD); $2 = relational path; $3 name for var which will hold result ###
  if [ -z $3 ]; then
  echo -e '!!!!!ERROR!!!!!\nERROR: 3 string needed:\n $1 = path prefix (e.g. $PWD);\n $2 = relational path;\n $3 = name of the predeclared variable which will hold result of this function\n!!!!!ERROR!!!!!'
  exit 1;
  fi

  local path_prefix=$1
  local path_suffix=$2
  declare -n path_prettifier_result=$3

  local split_prefix
  split $path_prefix / split_prefix
  local split_suffix
  split $path_suffix / split_suffix

  local filtered_prefix=(${split_prefix[@]})
  
  local -i i=0

  for dir in ${split_suffix[@]}; do
    if [[ $dir = "." ]]; then
      :
    elif [[ $dir = ".." ]]; then
      unset 'filtered_prefix[${#filtered_prefix[@]}-1]'
    else
      break
    fi

    i+=1

  done

  while (( $i < ${#split_suffix[@]} )); do
    local -n dir=split_suffix[$i]

    if [[ $dir = "." ]]; then
      :
    elif [[ $dir = ".." ]]; then
      unset 'filtered_suffix[${#filtered_suffix[@]}-1]'
    else  
      filtered_suffix+=($dir)
    fi
    
    i+=1
  done

  # path_prettifier_result=(${filtered_prefix[@]} ${filtered_suffix[@]})
  joined_arrays=(${filtered_prefix[@]} ${filtered_suffix[@]})

  join joined_arrays  path_prettifier_result /
  path_prettifier_result="/$path_prettifier_result"
  
}
declare -a path=()
echo $PWD
echo $(dirname "$0")
path_prettifier $PWD .././../abd/del/../sdfsdf/s/del/del/./../../end path
path_prettifier $(dirname "$0") .././../abd/del/../sdfsdf/s/del/del/./../../end path
echo ${path[@]}
echo "$(dirname "$0")$path"