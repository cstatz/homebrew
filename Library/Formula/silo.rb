require 'formula'

class Silo < Formula
  homepage 'https://wci.llnl.gov/codes/silo/index.html'
  url 'https://wci.llnl.gov/codes/silo/silo-4.8/silo-4.8-bsd.tar.gz'
  md5 '03e27c977f34dc6e9a5f3864153c24fe'

  def options
  [
    ['--python','Enable python wrappers'],
    ['--hdf5','Build silo with hdf5 support'],
    ['--fortran','Enable fortran support']
  ]
  end
  
  depends_on 'python' if ARGV.include? '--python'
  depends_on 'hdf5' if ARGV.include? '--hdf5'

  def install

    args = [
      "--prefix=#{prefix}",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silex",
      "--disable-browser"
    ]

    if ARGV.include? '--fortran'
      args << "--enable-fortran"
    else
      args << "--disable-fortran"
    end

    if ARGV.include? '--python'
      python = Formula.factory('python')
      args << "--enable-pythonmodule"
    end

    if ARGV.include? '--hdf5' 
      szip = Formula.factory('szip')
      hdf5 = Formula.factory('hdf5')
      args << "--with-szlib=#{szip.prefix}"
      args << "--with-hdf5=#{hdf5.include},#{hdf5.lib}"
    end
    
    system "./configure", *args
    system "make install"

  end

  #def test
  #  system "make check"
  #end
end
