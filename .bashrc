# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aes and functions
export PS1='[\u@\h `pwd`]\$'
alias a="alias"
a   gv="gvim"
a   gdfl="git diff --name-only HEAD^ HEAD"
a   gdf="rm -rf git_diff_file_tmp.v; git show HEAD^1:\!:1 > git_diff_file_tmp.v; gvimdiff \!:2 git_diff_file_tmp.v;"
a   bdf="rm -rf git_diff_file_tmp.v; git show HEAD^1:\!:1 > git_diff_file_tmp.v; b \!:2 git_diff_file_tmp.v;"
a   g="gvim -p"

a   la="ll -a"
a   lla="ls -a"
a   ..="cd ../;la"
a   ...="cd ../../;la"
a   ....="cd ../../../;la"
a   .....="cd ../../../../;la"
a   ......="cd ../../../../../;la"
a   cdv="cd ~/.vim"
a   cc="cd ../;la"
a   ccc="cd ../../;la"
a   cccc="cd ../../../;la"
a   ccccc="cd ../../../../;la"
a   cccccc="cd ../../../../../;la"
a   sb="source ~/.bashrc"
a   sc="source ~/.bashrc"
a   gg="g ~/vim/syntax/vim_usr_cfg.vim"
a   gc="g ~/vim/.bashrc"
a   md="mkdir"
a   sppc="source    /home/ICer/ic_prjs/riscv/digital_data/script/Project.cshrc"
a   cdpj="cd        /home/ICer/ic_prjs/riscv/digital_data/"
a   cd32s="cd       /home/ICer/ic_prjs/riscv/digital_data/verifaction/st/sim"
a   gt="/usr/bin/gnome-terminal --tab&"
cd() { builtin cd "$@" && ls; }


a   h=history
#=============================================================================================
#   Synopsys Tools
#=============================================================================================
export DVE_HOME=/home/synopsys/vcs-mx/O-2018.09-1
#export DVE_HOME=/home/synopsys/vcs/O-2018.09-SP2
#export DVE_HOME=/home/synopsys/vcs-mx/O-2018.09-SP2

#export VCS_HOME=/home/synopsys/vcs-mx/O-2018.09-1
export VCS_HOME=/home/synopsys/vcs/O-2018.09-SP2
#export VCS_HOME=/home/synopsys/vcs-mx/O-2018.09-SP2

export VERDI_HOME=/home/synopsys/verdi/Verdi_O-2018.09-SP2
export SCL_HOME=/home/synopsys/scl/2018.06
export DC_HOME=/home/synopsys/syn/O-2018.06-SP1
export LC_HOME=/home/synopsys/lc/O-2018.06-SP1
export SPYGLASS_HOME=/home/synopsys/SpyGlass-L2016.06/SPYGLASS_HOME/
export PT_HOME=/home/synopsys/pts/O-2018.06-SP1
export ICC2_HOME=/home/synopsys/icc2/O-2018.06-SP1
export SYNPLIFY_HOME=/home/synopsys/fpga/N-2018.03-SP1
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$VERDI_HOME/share/PLI/lib/LINUX64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$VERDI_HOME/share/PLI/IUS/LINUX64/boot"
#Synplify
PATH=$PATH:$SYNPLIFY_HOME/bin
a synplify="synplify"

#PT
PATH=$PATH:$PT_HOME/bin
a pt="pt_shell"

#ICC2
PATH=$PATH:$ICC2_HOME/bin
a icc2="icc2_shell"

#DC
PATH=$PATH:$DC_HOME/bin
a dc="dc_shell"
a dv="design_vision"

#lib compile
PATH=$PATH:$LC_HOME/bin
a lc="lc_shell"

#Spyglass
PATH=$PATH:$SPYGLASS_HOME/bin
a spyglass="spyglass"


#Dve
PATH=$PATH:$DVE_HOME/gui/dve/bin
a dve="dve -full64"

#VCS
PATH=$PATH:$VCS_HOME/bin
a vcs="vcs"


#Verdi
PATH=$PATH:$VERDI_HOME/bin
a verdi="verdi"

#scl
PATH=$PATH:$SCL_HOME/linux64/bin
export VCS_ARCH_OVERRIDE=linux

#SynopsysInstaller
PATH=$PATH:$SYNOP_INSTALL50_HOME
a SYN_install="/home/synopsys/SynopsysInstaller_v5.0/setup.sh &"
#=============================================================================================
#   Candence Tools
#=============================================================================================
#source ~/cadence.bashrc

export CADHOME=/home/cadence
export MGC_HOME=/home/mentor/
export CDSHOME=$CADHOME/IC617
export INCISIVE_HOME=$CADHOME/INCISIVE152
export MMSIMHOME=$CADHOME/MMSIM151

export CALIBRE_HOME=$MGC_HOME/Calibre2015/aoi_cal_2015.2_36.27
export MGC_LICENSE_FILE=$MGC_HOME/license/license.dat
export MGC_CALIBRE_SCHEMATIC_SERVER=IC_EDA:9199
export MGC_CALIBRE_LAYOUT_SERVER=IC_EDA:9189
export PATH=$PATH:$CDSHOME/tools/dfII/bin:$CDSHOME/tools/plot/bin
export PATH=$PATH:$INCISIVE_HOME/tools/bin
export CDS_LIC_FILE=$CADHOME/license/cadence.dat
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INCISIVE_HOME/tools.lnx86/lib
export PATH=$PATH:$MMSIMHOME/bin:$MMSIMHOME/tools/relxpert/bin

export SPECMAN_HOME=$INCISIVE_HOME/components/sn
export SPECMAN_DIR=$SPECMAN_HOME/
export PATH="$PATH:$INCISIVE_HOME/bin"
export PATH="$PATH:$INCISIVE_HOME/tools.lnx86/bin"
export PATH="$PATH:$INCISIVE_HOME/tools.lnx86/dfII/bin"

#irun
a irun="irun"

#simvision
a simv="simvision -64 &"
a simvision="simvision"

#ncvlog
a ncvlog="ncvlog"

#ncsim
a ncsim="ncvsim"

#ncelab
a ncelab="ncelab"

#ncvhdl_p
a ncvhdl_p="ncvhdl_p"

#ncvhdl_p
a imc="imc"

#virtuoso
a virtuoso="virtuoso"

#iscape.sh
a CAD_install="/home/cadence/InstallScape/iscape.04.23-s010/bin/iscape.sh &"


#=============================================================================================
#   Mentor Tools
#=============================================================================================
export QUESTASIM_HOME=/home/mentor/questasim

export PATH=$PATH:$QUESTASIM_HOME/linux_x86_64

#Questasim
a vsim="vsim"
a questasim="vsim"


#=============================================================================================
#   Xilinx Tools
#=============================================================================================
source /home/Xilinx/Vivado/2019.1/settings64.sh


#=============================================================================================
#   RISCV Tools
#=============================================================================================
export RISCV=/home/Riscv_Tools
export QEMU_HOME=$RISCV/riscv-gnu-toolchain/qemu-6.0.0
PATH=$PATH:$RISCV/bin
PATH=$PATH:$QEMU_HOME/build/riscv32-linux-user
a qemu32='qemu-riscv32';
a rv32_elf='riscv32-unknown-elf-gcc';



#=============================================================================================
# Synopsys & Cadence LICENCE
#=============================================================================================

export SNPSLMD_LICENSE_FILE=27000@IC_EDA
export MGLS_LICENSE_FILE=/home/mentor/questasim/mentor.dat

a lmg_synopsys="/home/synopsys/scl/2018.06/linux64/bin/lmgrd -c /home/synopsys/scl/2018.06/admin/license/Synopsys.dat"
a lmg_mentor="/home/mentor/questasim/linux_x86_64/lmgrd -c /home/mentor/questasim/mentor.dat"
a kill_lmg="sudo killall lmgrd"
a relmg="kill_lmg && lmg_synopsys && lmg_mentor"
#=============================================================================================
# arm-m0-gcc
#=============================================================================================
export ARM_M0_GCC_PATH=/opt/gcc-arm-none-eabi-10.3-2021.10/bin:$ARM_M0_GCC_PATH


#=============================================================================================
# Others
#=============================================================================================
a t='gnome-terminal';
export PATH=/usr/local/gcc-10.2.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gcc-10.2.0/lib64:$LD_LIBRARY_PATH

export PATH=$PATH:/usr/bin

a vtags="python ~/.vim/bundle/vtags-3.11/vtags.py"


#=============================================================================================
# Python3.9
#=============================================================================================

export PYTHON_HOME=/usr/local/python3.9
export PATH=$PYTHON_HOME/bin:$PATH

export PATH=$PATH:/snap/bin




