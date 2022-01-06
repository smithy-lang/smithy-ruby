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

package software.amazon.smithy.ruby.codegen.integrations;

import java.util.Arrays;
import java.util.List;
import software.amazon.smithy.ruby.codegen.ProtocolGenerator;
import software.amazon.smithy.ruby.codegen.RubyIntegration;
import software.amazon.smithy.ruby.codegen.test.protocol.fakeprotocol.FakeProtocolGenerator;
import software.amazon.smithy.utils.SmithyInternalApi;

/**
 * Provide support for whitelabel testing (implements fakeProtocol).
 */
@SmithyInternalApi
public class TestIntegration implements RubyIntegration {

    @Override
    public List<ProtocolGenerator> getProtocolGenerators() {
        return Arrays.asList(new FakeProtocolGenerator());
    }
}
