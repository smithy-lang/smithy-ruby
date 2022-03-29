# frozen_string_literal: true

module Hearth
  describe Checksums do
    context 'File' do
      it 'computes the MD5' do
        f = File.new('hearth-checksum-test', 'w+')
        f.write('md5 me captain')
        f.rewind
        md5 = subject.md5(f)
        expect(md5).to eq('hjqFDScUdwq9I6RDVIBNUA==')
        f.close
        File.delete('hearth-checksum-test')
      end
    end

    context 'Tempfile' do
      it 'computes the MD5' do
        tf = Tempfile.new('hearth-checksum-test')
        tf.write('md5 me captain')
        tf.rewind
        md5 = subject.md5(tf)
        expect(md5).to eq('hjqFDScUdwq9I6RDVIBNUA==')
        tf.close
        tf.unlink
      end
    end

    context 'StringIO' do
      it 'computes the MD5 by reading 1MB at a time' do
        body = StringIO.new('.' * 5 * 1024 * 1024) # 5MB
        expect(body).to receive(:read)
          .with(1024 * 1024, any_args)
          .exactly(5 + 1).times.and_call_original
        md5 = subject.md5(body)
        expect(md5).to eq('+kDD2/74SZx+Rz+/Dw7I1Q==')
      end
    end

    context 'String' do
      it 'computes the MD5' do
        md5 = subject.md5('md5 me captain')
        expect(md5).to eq('hjqFDScUdwq9I6RDVIBNUA==')
      end
    end
  end
end
