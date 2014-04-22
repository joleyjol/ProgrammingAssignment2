## These functions demonstrate how it's possible to cobble together a class in R

makeCacheMatrix <- function(x = matrix()) {
	# Our cached inverse (instance variable)
	i <- NULL
	# Four methods for getting and setting the cached value
	set <- function(y) {
		x <<- y
		i <<- NULL
	}
	get <- function() x
	setinv <- function() {
		# print("Setting i")
		i <<- solve(x)
	}
	getinv <- function() {
		if (is.null(i)) {
			i <- setinv()
		}
		# print("Getting i")
		i
	}
	# Return a list that behaves like a class with four methods
	# which are accessible as named items of the list
	list(set = set, get = get,
		setinv = setinv,
		getinv = getinv
	)
}

## Silly function that throws away the cache as soon as
## we create it
cacheSolve <- function(x, ...) {
	## Return a matrix that is the inverse of 'x'
	cm = makeCacheMatrix(x)

	# If you call this multiple times you would see Getting but not Setting
	# (if you uncomment the print statements above)
	# cm$getinv()
	cm$getinv()
}

