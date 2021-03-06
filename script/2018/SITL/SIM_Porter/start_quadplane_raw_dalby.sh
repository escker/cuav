#!/bin/bash
OBC=$HOME/project/UAV/APM.obc2018

pushd $OBC
./waf configure --board sitl --debug
./waf plane
popd

[ -z "$UART_RETRIEVAL" ] && {
    UART_RETRIEVAL="uart:../radio_retrieval"
}

HOME="-27.274439,151.290064,343,8.7"

$OBC/build/sitl/bin/arduplane --home $HOME --model quadplane-ice -I 2 --uartA tcp:0 --uartC $UART_RETRIEVAL --defaults $OBC/Tools/autotest/default_params/quadplane.parm $*

