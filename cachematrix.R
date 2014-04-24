## These functions demonstrate how it's possible to cobble together a class in R

makeCacheMatrix <- function(x = matrix()) {
	# Our cached inverse (instance variable)
	i <- NULL

	#
	# Four methods for getting and setting the cached value
	#

	# setter function to update the base variable
	set <- function(y) {
		# x is our base variable
		x <<- y
		# reset inverse when x is updated
		i <<- NULL
	}

	# getter function for returning the base variable
	get <- function() x

	# function for computing the inverse, also called by
	# getinv if not previously computed
	setinv <- function() {
		# print("Setting i")
		i <<- solve(x)
	}

	# returns the inverse
	getinv <- function() {
		# check if we have previously computed the inverse
		if (is.null(i)) {
			# if not, recompute it
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

	# cm holds the original base matrix as well as the inverse
	cm = makeCacheMatrix(x)

	# If you call this multiple times you would see Getting but not Setting
	# (if you uncomment the print statements above)
	# cm$getinv()
	cm$getinv()
}

