
# 
# @AUTHOR :: Stjepan Bilić Matišić
# @ABOUT  :: Simple shell script to
#            build a cross-compiler
#

# Exports
export PREFIX="$HOME/Toolchain/i686-elf"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
export TOOLCHAIN="$HOME/Toolchain/i686-elf"

# Downloads
wget https://ftp.gnu.org/gnu/gcc/gcc-11.1.0/gcc-11.1.0.tar.gz
wget https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz

# Directory Setup
tar -xvf binutils-2.37.tar.xz
tar -xvf gcc-11.1.0.tar.gz

mkdir binutils-build
mkdir gcc-build

# Binutils
cd binutils-build
    ../binutils-2.37/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
    make -j4
    make -j4 install
cd ..

# GCC
cd gcc-build

    ../gcc-11.1.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
    make -j4 all-gcc
    make -j4 all-target-libgcc
    make -j4 install-gcc
    make -j4 install-target-libgcc

cd ..

# Toolchain Test
./toolchain-test/build.sh

# "Perma" Export
echo "# CROSS-COMPILER STUFF" >> ~/.bashrc 
echo "export PREFIX="$HOME/Toolchain/i686-elf" " >> ~/.bashrc 
echo "export TARGET=i686-elf" >> /.bashrc
echo "export PATH="$PREFIX/bin:$PATH" " >> ~/.bashrc
echo "export TOOLCHAIN="$HOME/Toolchain/i686-elf" " >> ~/.bashrc
