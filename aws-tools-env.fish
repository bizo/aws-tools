#
# aws-tools-env.fish
# 
# A utility for lifting the variables exported by aws-tools-env.sh into fish.
#

#
# Find the absolute path of the aws-tools-env.sh script.
#
set -l aws_env_sh (dirname (status -f))"/aws-tools-env.sh"

#
# Extract the names of the variables that are set by the script.
#
egrep "^\\s*export " $aws_env_sh | while read e
  set aws_vars_tmp $aws_vars_tmp (echo $e | sed -E "s/^\\s*export ([a-zA-Z0-9_]+)=(.*)\$/\1/")
end
set -l aws_vars $aws_vars_tmp
set -e aws_vars_tmp

#
# Execute the script and collect the exported variables.
#
set -l aws_envs (echo ". $aws_env_sh ; printenv" | bash)

#
# Scan through the exported variables and lift those set by the script into the fish environment.
#
for e in $aws_envs
  set -l aws_var_name (echo $e | sed -E "s/^([a-zA-Z0-9_]+)=(.*)\$/\1/")
  set -l aws_var_value (echo $e | sed -E "s/^([a-zA-Z0-9_]+)=(.*)\$/\2/")
  if contains $aws_var_name $aws_vars
    if test $aws_var_name = "PATH"
      # Special handling for the multiple values in PATH.
      set -l values (echo $aws_var_value | sed -E "s/:/ /g")
      eval set -xg fish_user_paths $fish_user_paths $values
    else
      set -xg $aws_var_name $aws_var_value
    end
  end
end

#
# Exit with '0'
#
echo >/dev/null
