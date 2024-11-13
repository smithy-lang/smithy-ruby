$version: "2.0"
namespace smithy.ruby.tests

@paginated(inputToken: "nextToken", outputToken: "nextToken")
@http(method: "POST", uri: "/paginators_test")
operation PaginatorsTest {
    input: PaginatorsTestInput,
    output: PaginatorsTestOutput
}

@paginated(inputToken: "nextToken", outputToken: "nextToken", items: "items")
@http(method: "POST", uri: "/paginators_test_with_items")
operation PaginatorsTestWithItems {
    input: PaginatorsTestInput,
    output: PaginatorsTestOutput
}

structure PaginatorsTestInput {
    nextToken: String
}

structure PaginatorsTestOutput {
    nextToken: String,
    items: Items
}

@paginated(inputToken: "__nextToken", outputToken: "__wrapper.__123nextToken", items: "__items")
@http(method: "POST", uri: "/paginators_test_with_bad_names")
operation __PaginatorsTestWithBadNames {
    input: __PaginatorsTestWithBadNamesInput,
    output: __PaginatorsTestWithBadNamesOutput
}

structure __PaginatorsTestWithBadNamesInput {
    __nextToken: String
}

structure __PaginatorsTestWithBadNamesOutput {
    __wrapper: ResultWrapper,
    __items: Items
}

structure ResultWrapper {
    __123nextToken: String
}

list Items {
    member: String
}
