# Bookmarks

function jump() {

    FZF_ARGS='-e +x --print-query --expect=ctrl-x,ctrl-i,ctrl-f,ctrl-c,ctrl-b,ctrl-h'

    F=$(
    { dirs -v; ls -d "$1"*/ ; D=`pwd`; while [ "$D" != / ]; do D=`dirname $D`; echo "$D"; done; } 2>/dev/null | \
        fzf $FZF_ARGS --preview="echo {}; [ -d {} ] && ls -latrh {}" | {
      read query;
      read expect;
      IFS='' read dir; #read whole line w/ whitespace.
      cat  2>/dev/null #flush rest of input

      case "$expect" in
          ctrl-h) echo "$1./";;
          ctrl-b) jump "$1../";;
          ctrl-c) echo "exit";;
          ctrl-x) echo "$query";;
          ctrl-[if])
              if dirs -v | grep -q "^$dir\$"; then
                  dir="$(echo "$dir" | sed -E 's/^ *([0-9]+) *//')"
              fi
              jump "$dir"
              ;;
          "")
              if dirs -v | grep -q "^$dir\$"; then echo "$dir" | sed -E 's/^ *([0-9]+) *.*$/+\1/';
              elif test "$dir"; then echo "$dir";
              elif test "$query"; then echo "$query";
              else echo ""
              fi
              ;;
      esac
    }
    )

    if test "$1"; then
        echo "$F"
        return 0
    fi

    if test "$F" = "exit"; then
        return 0
    fi

    if test "$DEBUG"; then
        dirs -v >&2
        echo -e "F=$F\n" >&2
        echo "pushd \"$F\" >/dev/null"  >&2
    fi
    
    pushd "$F" >/dev/null

    #dedup directory stack
    declare -A seen
    i=0
    # reads dirs -p into array by line. IFS=$'\n' will split by newline, $'\n' will escape correctly.
    IFS=$'\n' GLOBIGNORE='*' command eval  'ODIRS=($(dirs -p))'
    # below *must* use for loop, while loops run in subshells and popd will not
    # affect outer shell.
    for ix in ${!ODIRS[@]} ; do
        d="${ODIRS[$i]}"
        if test "${seen[$d]}"; then
            popd -n +$i >/dev/null ;
        else ((i++));
        fi
        seen[$d]=1
    done;

}


