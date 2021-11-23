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

list Items {
    member: String
}