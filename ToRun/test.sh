
config_name=$1

if [[ $config_name == "ul_2016_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c"
    datatautau="data_tau_a,data_tau_b,data_tau_c"
elif [[ $config_name == "ul_2016_HIPM_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e"
    datatautau="data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e"
elif [[ $config_name == "ul_2017_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c,data_etau_d,data_etau_e"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d,data_mutau_e"
    datatautau="data_tau_a,data_tau_b,data_tau_c,data_tau_d,data_tau_e"
elif [[ $config_name == "ul_2018_ZZ_v10" ]]; then
    dataetau="data_etau_a,data_etau_b,data_etau_c,data_etau_d"
    datamutau="data_mutau_a,data_mutau_b,data_mutau_c,data_mutau_d"
    datatautau="data_tau_a,data_tau_b,data_tau_c,data_tau_d"
fi

echo $dataetau