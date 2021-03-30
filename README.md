# ElementosFinitos
Este repositorio es un trabajo en progreso donde se desea recopilar una serie de implementaciones de las ecuaciones y formulas para entender las bases de los elementos finitos.

## Contenido
Esta conformado por las implementaciones:
* Sistema_resorte (__completado__): solución de deflecciones y reacciones un sistema de resortes interconectados.     
* Truss (__completado__): solución para elementos tipo truss (elementos con cargas axiales) en 1, 2 o 3 dimensiones. 
* Beam (__completado__): solución para elementos tipo viga
* Frame (__en desarrollo__): solución para elementos tipo Frame (uniones rigidas, elementos experimenta deflecciones y  momentos) 


## A desarrollar
[] Compatibilidad con entrada gmsh y salida pos
[] Elementos tipo frame

## Sobre este proyecto
Esta organizado en forma de proyecto de matlab, para inicializarlo se realiza doble click sobre el archivo ```ElementosFinitos.prj``` en el explorar de archivos  o se puede escribir escribir el siguiente comando en consola.

```    
    openProject ElementosFinitos.prj
```

Para verificar el correcto funcionamiento del proyecto:

```    
    projEF=currentProject
```

### Configuración del proyecto
A continuación se ilustran los comandos que fueron utilizados al momento de configurar el proyecto 
```
check = fullfile("test","verificacion.m");
addFile(projEF,check)
addStartupFile(projEF,check)
```

utiliza herramientas de control de versiones, la filosofia de CI (continuos integration/ integración continua) y la validación del codigo mediante tests para brindar un codigo robusto. Ademas esta contenido en un proyecto de matlab. 

para ver mas información sobre como integrar control de versiones o CI en matlab ver los siguientes videos.

* [trabajo colaborativo](https://es.mathworks.com/videos/bulletproofing-collaborative-softwarevelopment-with-matlab-and-simulink-1589347030586.html)
* [documentación git en matlab](https://es.mathworks.com/help/matlab/matlab_prog/set-up-git-source-control.html)



## Documentación 
Para la documentación se utiliza un archivo _livescript_ el cual sera exportado a formato html y PDF 



