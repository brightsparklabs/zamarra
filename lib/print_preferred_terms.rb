require './zamarra/reader'
require './zamarra/writer'

include Zamarra

document = Reader.read_zthes_xml ARGV[0]
Writer.write_preferred_terms document
