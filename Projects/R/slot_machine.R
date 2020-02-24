
## Ejemplo Máquina Tragaperras 
## Probabilidades:
##          DD: 0.03 
#           7:0.03 
#           BBB: 0.06 
#           BB:0.1 
#           B:0.25 
#           C:0.01 
#           0:0.52    
## Por cada euro que jugamos, ¿cuanto dinero ganamos o perdemos? 


# 1º Funcion: get_symbols for me

#maquina<-list(whele=c("DD","7","BBB","BB","B","C","0")
# prob=c("0.03","0.03","0.06","0.1", "0.25", "0.01", "0")




#get_symbols<-function(whele,prob{
# 
# }

get_symbols<-function(){
  whele<-c("DD","7","BBB","BB","B","C","0")
  sample(whele, size = 3, replace = TRUE,
         prob =c("0.03","0.03","0.06","0.1", "0.25", "0.01", "0.52"))
}

# 2º scores: lo que vamos a ganar for me

#score<-function(x){
#  if(x[1]==x[2]&x[1]==x[3]){
#    print("PREMIO")
#  }else{
#  print("No premio")
#  }
# } #
# 
# 2º 
# score<-function(x){
#   
#  # if(length(unique(x))==1){
#   #  if(x[1]=="DD"){
#       print("Premio")
# #      points<-100
#       
# #    }else if{(x[1]=="BBB"){
#       print("Premio")
#  #     points<-80
#       
# #    }else if{x[1]=="BBB"{
#       print("Premio")
#       points<-
#   #  }
#  #   }
# #       
# 
# 
# 2º Versión extensa    
# score<-function(x){
#   same<-x[1]==x[2]&x[1]==x[3]
#   
#   if(same & x[1]!=0){
#     print("PREMIO")
#   if(x[1]=="DD"){
#     points<-100
#   }else if(x[1]=="7"){
#     points<-80
#   }else if(x[1]=="BBB"){
#     points<-40
#   }else if(x[1]=="BB"){
#     points<-25
#   }else{
#     points<-10
#   }
#   print(paste("premio", puntos, sep = ":")) 
#   }else{
#     points<-0
#     print("No premio")
#   }
#   return(points)
# }
#       


# 2º
score<-function(x){
  same<-x[1]==x[2]&x[1]==x[3] #same devuelve logico
  bars<-sum(x %in% c("B","BB","BBB")) #de mi vector x cuantos elementos estan en este otro vector
  nc<- sum(x=="c") #no aparece porque se queda dentro de la propia funcion
  
  if(same & x[1]!=0){ #todos son iguales y distinto 0
    payout=c("DD"=100,"7"=80,"BBB"=40,"BB"=25, "B"=10,"C"=10)
    points<-unname(payout[x[1]])
    # print(paste("PREMIO",points,sep=':'))
    
  }else if(bars==3 & !same){
    points<-5
    # print(paste("PREMIO",points,sep=':'))
  }else{
    payout.cherry<-c(0,2,5)#es un vector que toma los valores de 0,2,5 hay que recordar que en R empieza en indice 1
    points<-payout.cherry[nc+1] 
    # print(paste("PREMIO",points,sep=':'))
  }
  if (points>0){
    print(paste("PREMIO",points,sep=':'))
  }else{
    print("No premio") #sin el print no veriamos nada
  }
  return(points)
}  
# 
# else{
#   points<-0
#   print("No premio")
# }
# return(points)


# ESTO ES PARA PROBAR NUESTRO CODIGO 
# symbols<-get_symbols() 
# print(symbols)
# points<-score(symbols)
# print(points)

# 3º 
play<-function(){
  symbols<-get_symbols()
  print(symbols)
  points<-score(symbols)
  return(points)
}

# Generar un vector(tirada) que tire play 
throw<-numeric()
for (i in 1:100){ #esto tiene que ser un vector nº o caracter 
  throw[i]<-play() #cada resultado de correr la funcion play en la variable a
}
print(symbols)
print(points)

plays<-matrix(nrow=100, ncol=3) #tenemos que señalicemos, es una matrix
for (i in 1:100){plays[i,]<- get_symbols()}

#Alternative 1  
s<-numeric()
for (i in 1:100){
    s[i]<-score(plays[i,])
}

#Alternative 2
s<-apply(plays,1,score) #cogemos el objeto y le decimos para todas tus files que eso es lo que significa 1
# ejecutalo, se puede utilizar tanto para una matrix o dataframe 

# load the script → source("")
