grep '_load_env.sh'  ~/.bashrc \
  && echo "Skipping .bashrc, it already loads env" \
  || echo ". ~/_load_env.sh" >> ~/.bashrc

grep '_load_env.sh'  ~/.bash_profile \
  && echo "Skipping .bashrc, it already loads env" \
  || echo ". ~/_load_env.sh" >> ~/.bash_profile
