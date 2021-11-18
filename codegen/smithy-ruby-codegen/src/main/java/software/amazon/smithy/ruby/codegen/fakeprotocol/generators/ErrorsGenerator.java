package software.amazon.smithy.ruby.codegen.fakeprotocol.generators;

import software.amazon.smithy.ruby.codegen.GenerationContext;

public class ErrorsGenerator extends software.amazon.smithy.ruby.codegen.generators.ErrorsGenerator {

    public ErrorsGenerator(GenerationContext context) {
        super(context);
    }

    public void renderErrorCode() {
        writer
                .write("# Given an http_resp, return the error code")
                .openBlock("def self.error_code(http_resp)")
                .write("http_resp.headers['x-smithy-error']")
                .closeBlock("end");
    }
}
