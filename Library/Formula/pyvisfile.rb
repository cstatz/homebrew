require 'formula'

class Pyvisfile < Formula

  homepage ''
  #url 'http://pypi.python.org/packages/source/p/pyvisfile/pyvisfile-2011.1.tar.gz#md5=7f59a690024094a884e08f6b126027d8'
  #md5 '7f59a690024094a884e08f6b126027d8'

  head 'https://github.com/inducer/pyvisfile.git'

  depends_on 'boost'
  depends_on 'python'
  depends_on 'silo'
  depends_on 'szip'
  depends_on 'hdf5'
  depends_on 'pyublas'

  def install

    boost = Formula.factory('boost')    
    silo = Formula.factory('silo')    
    hdf5 = Formula.factory('hdf5')
    szip = Formula.factory('szip')

    args = [ 
      "--boost-inc-dir=#{boost.include}",
      "--boost-lib-dir=#{boost.lib}",
      "--boost-python-libname=boost_python-mt",
      "--use-silo",
      "--silo-inc-dir=#{szip.include},#{hdf5.include},#{silo.include}",
      "--silo-lib-dir=#{szip.lib},#{hdf5.lib},#{silo.lib}",
      "--silo-libname=sz,hdf5,siloh5"
    ]   
 

    system "/usr/local/bin/python", "configure.py", *args
    system "/usr/local/bin/python", "setup.py", "build"
    system "/usr/local/bin/python", "setup.py", "install"

  end 

end
