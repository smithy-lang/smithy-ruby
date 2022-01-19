$version: "1.0"
namespace smithy.ruby.tests

@paginated(inputToken: "nextToken", outputToken: "nextToken")
operation PaginatorsTest {
    input: PaginatorsTestInput,
    output: PaginatorsTestOutput
}

@paginated(inputToken: "nextToken", outputToken: "nextToken", items: "items")
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