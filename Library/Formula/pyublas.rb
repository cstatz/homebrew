require 'formula'

class Pyublas < Formula
  homepage ''
  url 'http://pypi.python.org/packages/source/P/PyUblas/PyUblas-2011.1.tar.gz#md5=b0a151d152d1d21bdeeab5d629edc145'
  md5 'b0a151d152d1d21bdeeab5d629edc145'

  depends_on 'boost'
  depends_on 'python'

  def install

    boost = Formula.factory('boost')    

    args = [
      "--use-iterators",
      "--with-sparse-wrappers",
      "--boost-inc-dir=#{boost.include}",
      "--boost-lib-dir=#{boost.lib}",
      "--boost-python-libname=boost_python-mt"
    ]   
 

    system "/usr/local/bin/python", "configure.py", *args
    system "/usr/local/bin/python", "setup.py", "build"
    system "/usr/local/bin/python", "setup.py", "install"

  end

end
