$version: "1.0"
 namespace example.weather

 use smithy.railsjson#ErrorName
 use smithy.railsjson#RailsJson
 use smithy.railsjson#NestedAttributes

 /// Provides weather forecasts.
 @RailsJson
 service Weather {
     version: "2006-03-01",
     resources: [City],
 }

 // Defining the City resource here is mostly equivalent to
 // Adding operations: [GetCity, CreateCity, UpdateCity, DeleteCity, ListCities]
 // to the Service definition above

 resource City {
     identifiers: { cityId: CityId },
     read: GetCity,
     create: CreateCity,
     update: UpdateCity,
     delete: DeleteCity,
     list: ListCities
 }

 // "pattern" is a trait.
 @pattern("^[A-Za-z0-9 ]+$")
 string CityId

 @readonly
 @http(method: "GET", uri: "/cities/{cityId}", code: 200)
 operation GetCity {
     input: GetCityInput,
     output: GetCityOutput,
     errors: [NotFound]
 }

 structure GetCityInput {
     // "cityId" provides the identifier for the resource and
     // has to be marked as required.
     @required
     @httpLabel
     cityId: CityId
 }

 structure GetCityOutput {
     // "required" is used on output to indicate if the service
     // will always provide a value for the member.
     @required
     name: String,

     @required
     coordinates: CityCoordinates,
 }

 // This structure is nested within GetCityOutput.
 structure CityCoordinates {
     @required
     latitude: Float,

     @required
     longitude: Float,
 }

 // "error" is a trait that is used to specialize
 // a structure as an error.
 @error("client")
 @httpError(404)
 @ErrorName(errorText: "Not Found")
 structure NotFound {
     @required
     resourceType: String
 }


 @http(method: "POST", uri: "/cities", code: 200)
 operation CreateCity {
     input: CreateCityInput,
     output: CreateCityOutput,
 }

 structure CreateCityInput {
     @required
     name: String,

     @required
     @NestedAttributes
     coordinates: CityCoordinates,
 }

 structure CreateCityOutput {
     @required
     @jsonName("id")
     cityId: CityId,

     @required
     name: String,

     coordinates: CityCoordinates,
 }

 @http(method: "PUT", uri: "/cities/{cityId}", code: 200)
 @idempotent
 operation UpdateCity {
     input: UpdateCityInput,
     output: UpdateCityOutput,
     errors: [NotFound]
 }

 structure UpdateCityInput {
     @required
     @httpLabel
     cityId: CityId,

     name: String,

     @NestedAttributes
     coordinates: CityCoordinates,
 }

 structure UpdateCityOutput {
     @required
     id: CityId,

     @required
     name: String,

     @required
     coordinates: CityCoordinates,
 }


 @http(method: "DELETE", uri: "/cities/{cityId}", code: 200)
 @idempotent
 operation DeleteCity {
     input: DeleteCityInput,
     output: DeleteCityOutput,
     errors: [NotFound]
 }

 structure DeleteCityInput {
     @required
     @httpLabel
     cityId: CityId,
 }

 structure DeleteCityOutput {
     @required
     cityId: CityId
 }

 // The paginated trait indicates that the operation may
 // return truncated results.
 @readonly
 @paginated(items: "items", pageSize: "maxResults", inputToken: "nextToken", outputToken: "nextToken")
 @http(method: "GET", uri: "/cities")
 operation ListCities {
     input: ListCitiesInput,
     output: ListCitiesOutput
 }

 structure ListCitiesInput {
     @httpQuery("nextToken")
     nextToken: String,

     @httpQuery("pageSize")
     maxResults: Integer,

     @httpHeader("X-Rails")
     rails: String
 }

 structure ListCitiesOutput {
     nextToken: String,

     @required
     items: CitySummaries,

     @httpHeader("Rails")
     rails: String
 }

 // CitySummaries is a list of CitySummary structures.
 list CitySummaries {
     member: CitySummary
 }

 structure CitySummary {
     @required
     name: String,

     @required
     coordinates: CityCoordinates
 }
