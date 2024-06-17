/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

package software.amazon.smithy.ruby.codegen.protocol.rpcv2cbor.generators;


import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.Hearth;
import software.amazon.smithy.ruby.codegen.generators.ErrorsGeneratorBase;

public class ErrorsGenerator extends ErrorsGeneratorBase {

    public ErrorsGenerator(GenerationContext context) {
        super(context);
    }

    @Override
    public void renderErrorCodeBody() {
        writer
                .write("")
                .openBlock("if !(200..299).cover?(resp.status)")
                .write("data = $T.decode(resp.body.read.force_encoding(Encoding::BINARY))", Hearth.CBOR)
                .write("resp.body.rewind")
                .write("code = data['__type'] if data")
                .closeBlock("end")
                .openBlock("if code")
                .write("code.split('#').last.split(':').first")
                .closeBlock("end")
                .dedent()
                .openBlock("rescue Hearth::Cbor::CborError")
                .write("\"HTTP #{resp.status} Error\"");
    }
}

