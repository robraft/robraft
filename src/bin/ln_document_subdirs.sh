
cd $HOME

[[ ! -h bin      && ! -d bin      ]] && ln -s gh/rr/src/bin           bin

[[ ! -h _JOB_    && ! -d hosts    ]] && ln -s Documents/__JOB         _JOB_

[[ ! -h hosts    && ! -d hosts    ]] && ln -s Documents/Tech/Hosts    hosts
[[ ! -h logs     && ! -d logs     ]] && ln -s Documents/Tech/logs     logs
[[ ! -h tmp      && ! -d tmp      ]] && ln -s Documents/Tech/tmp      tmp
[[ ! -h tproj    && ! -d tproj    ]] && ln -s Documents/Tech/tproj    tproj
[[ ! -h vimfiles && ! -d vimfiles ]] && ln -s Documents/Tech/vimfiles vimfiles

