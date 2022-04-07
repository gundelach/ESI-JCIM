for cutoff in $(ls | awk '/[0-9]N/ {print $0}');
do 
    cp split_csv_energy.sh ${cutoff}/
    cd ${cutoff}
    for i in {1..10};
    do
        bash split_csv_energy.sh BRD4-${i}_${cutoff}.csv     
    done
    cd -
done
