# 查看主板上的sata3硬盘温度
apt install hddtemp
hddtemp -n /dev/sda

# 查看cpu, memory温度
apt install lm-sensors
sensors-detect
sensors

# 查看适配器所有信息 非常详细
megacli -AdpAllInfo -aAll
# 查看逻辑磁盘状态和设置
megacli -LDInfo -LAll -aAll
# 查看物理磁盘状态和设置
megacli -PDList –aAll
# 查看物理设备温度
megacli pdlist aall | grep "Drive Temperature"

# 查看JBOD是否启用
megacli -AdpGetProp -enablejbod -aALL
# 所有适配器启用JBOD
megacli -AdpSetProp -enablejbod 1 -aALL
# 查看设备E:S
megacli pdlist aall | grep -Ei "Enclosure Device ID|Slot Number"
# 以下命令为设置适配器0号的一块物理盘E:S为JBOD模式
# E代表Enclosure Device ID, S代表Slot Number
# 通配不行的时候在bash而非zsh下运行
MegaCli -PDMakeJBOD -PhysDrv[E0:S0,E1:S1,...] -aN|-a0,1,2|-aALL
# 查看设备是否被设置为JBOD模式
megacli PDList -aALL -Nolog|grep '^Firm'

# 将一块盘上线
MegaCli -PDOnline  -PhysDrv[E0:S0,E1:S1,...] -aN|-a0,1,2|-aALL

# 清除所有Ld配置
megacli -CfgLdDel -LAll -aAll
