% script de verificación de resultados de los tests 
runChecks(currentProject)
cases=["test1_sistema_resorte.m",
        "truss/test3_truss_plano.m"];
    
results=runtests(cases)
