package software.amazon.smithy.ruby.codegen;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import software.amazon.smithy.build.MockManifest;
import software.amazon.smithy.codegen.core.Symbol;
import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.codegen.core.WriterDelegator;
import software.amazon.smithy.ruby.codegen.interceptors.ModuleBlockInterceptor;

import java.nio.file.Paths;
import java.util.List;

class ModuleBlockInterceptorTest {

    @Test
    void expectModulesGenerated() {
        MockManifest mockManifest = new MockManifest();

        SymbolProvider provider = (shape) -> Symbol.builder()
            .namespace("com.foo", ".")
            .name("Baz")
            .definitionFile("com/foo/Baz.bam")
            .build();

        WriterDelegator<RubyCodeWriter> delegator = new WriterDelegator<>(mockManifest, provider, new RubyCodeWriter.Factory());

        delegator.setInterceptors(List.of(
            new ModuleBlockInterceptor()
        ));

        String namespace = "TestService::Types";

        delegator.useFileWriter("types.rb", namespace, writer -> {
            writer.addModule("TestService");
            writer.addModule("Types");
        });

        delegator.useFileWriter("types.rb", namespace, writer -> {
            writer.write("$T", Symbol.builder().namespace(namespace, "::").name("StructA").build());
        });

        delegator.useFileWriter("types.rb", namespace, writer -> writer.addModule("Nested"));

        delegator.useFileWriter("types.rb", namespace, writer -> {
            writer.write("$T", Symbol.builder().namespace(namespace, "::").name("StructB").build());
        });

        delegator.useFileWriter("types.rb", namespace, RubyCodeWriter::closeModule);

        delegator.useFileWriter("types.rb", namespace, writer -> {
            writer.write("$T", Symbol.builder().namespace(namespace, "::").name("StructC").build());
        });

        // Close module blocks
        delegator.useFileWriter("types.rb",namespace, RubyCodeWriter::closeAllModules);

        Assertions.assertEquals(
    "# frozen_string_literal: true\n" +
            "\n" +
            "# WARNING ABOUT GENERATED CODE\n" +
            "#\n" +
            "# This file was code generated using smithy-ruby.\n" +
            "# https://github.com/awslabs/smithy-ruby\n" +
            "#\n" +
            "# WARNING ABOUT GENERATED CODE\n" +
            "\n" +
            "module TestService\n" +
            "  module Types\n" +
            "\n" +
            "    StructA\n" +
            "\n" +
            "    module Nested\n" +
            "\n" +
            "      StructB\n" +
            "\n" +
            "    end\n" +
            "\n" +
            "    StructC\n" +
            "\n" +
            "  end\n" +
            "\n" +
            "end\n",
            delegator.getWriters().get(
                Paths.get("types.rb").toString()).toString()
            );
    }
}