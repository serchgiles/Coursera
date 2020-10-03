## The function makeCacheMatrix returns an special object which contains a 
## set of functions which allow you to get and set a matrix and its inverse. 

makeCacheMatrix <- function(x = matrix()) {
        inverse <- NULL
        set <- function(y){
                inverse <<- NULL
                x <<- y
        }
        
        get <- function() x
        setInverse <- function(inv) inverse <<- inv
        getInverse <- function() inverse
        
        list(set = set, get = get,
             setInverse = setInverse,
             getInverse = getInverse)
        
}

## The other function, cacheSolve, take as argument the object returned by 
## makeCacheMatrix and first check if the inverse was already set to this 
## object. If not, then it proceeds to compute the inverse of the matrix setted
## in makeCacheMatrix and set that inverse to the object x

cacheSolve <- function(x, ...) {
        inverse <- x$getInverse()
        if(!is.null(inverse)){
                message("Getting cached data")
                return(inverse)
        }
        mat <- x$get()
        if (det(mat) == 0) {
                stop("The matrix is not invertible")
        }
        inverse <- solve(mat)
        x$setInverse(inverse)
        inverse
}