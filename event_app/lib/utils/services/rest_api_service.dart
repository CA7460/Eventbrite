// rest_api_service.dart: We do call the rest API to get, store data on a remote DATABASE
// for that we need to write the rest API call at a single place and need to return the data 
// if the rest call is a success or need to return custom error exception on the basis of 4xx, 5xx status code. 
// We can make use of http package to make the rest API call in the flutter