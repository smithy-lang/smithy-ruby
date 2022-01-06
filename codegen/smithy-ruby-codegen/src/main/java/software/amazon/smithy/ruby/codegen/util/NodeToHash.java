/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen.util;

import java.util.Map;
import java.util.stream.Collectors;
import software.amazon.smithy.model.node.ArrayNode;
import software.amazon.smithy.model.node.BooleanNode;
import software.amazon.smithy.model.node.Node;
import software.amazon.smithy.model.node.NodeVisitor;
import software.amazon.smithy.model.node.NullNode;
import software.amazon.smithy.model.node.NumberNode;
import software.amazon.smithy.model.node.ObjectNode;
import software.amazon.smithy.model.node.StringNode;
import software.amazon.smithy.ruby.codegen.RubyFormatter;
import software.amazon.smithy.utils.SmithyInternalApi;

@SmithyInternalApi
public class NodeToHash implements NodeVisitor<String> {

    @Override
    public String arrayNode(ArrayNode node) {
        String elements = node.getElements().stream()
                .map((element) -> element.accept(this))
                .collect(Collectors.joining(", "));

        return "[" + elements + "]";
    }

    @Override
    public String booleanNode(BooleanNode node) {
        return node.getValue() ? "true" : "false";
    }

    @Override
    public String nullNode(NullNode node) {
        return "nil";
    }

    @Override
    public String numberNode(NumberNode node) {
        return node.getValue().toString();
    }

    @Override
    public String objectNode(ObjectNode node) {
        Map<StringNode, Node> members = node.getMembers();
        String memberStr = members.keySet().stream()
                .map((k) -> "'" + RubyFormatter.toSnakeCase(k.toString()) + "' => " + members.get(k).accept(this))
                .collect(Collectors.joining(", "));

        return "{" + memberStr + "}";
    }

    @Override
    public String stringNode(StringNode node) {
        return "'" + node.getValue() + "'";
    }
}

