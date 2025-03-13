MEMORY
{
    vector  (rx)  : org = 0x04,         len = 192
    data    (r)   : org = 0xC0,         len = 65343
    program (rx)  : org = 0x08000000,   len = 65535
}

SECTIONS
{
    data    :   {*(.data)}          > data
    program :   {*(.text.program)}  > program
    RESET   :   {*(.text.vector)}    > vector
}
