describe 'ACliRC', () ->

  it 'before', () ->

    kosher.shell

    kosher.alias 'fixture', kosher.spec.fixtures.rc

    kosher.alias 'instance', new kosher.fixture.A

  describe 'properties', () ->

    describe 'rcfile', () ->

      it 'should have a value property', () ->

        expect("rcfile" of kosher.instance).to.be.ok

      it 'should be initialized', () ->

        expect(kosher.instance.rcfile).to.be.String

    describe 'options', () ->

      it 'should allow options to override rcfile location', () ->

        kosher.tmp = "a-cli-rc"

        kosher.alias 'instance', new kosher.fixture.A

          rcfile: resolve kosher.tmp, ".rcfile"

        kosher.instance.rcfile.should.eql resolve kosher.tmp, ".rcfile"

    describe 'value', () ->

      it 'should have a value property', () ->

        expect("value" of kosher.instance).to.be.ok

      it 'should not be initialized', () ->

        expect(kosher.instance.value).not.to.be.ok

    describe 'methods', () ->

      describe 'read', () ->

        it 'should not throw an error when file doesnt exist', () ->

          expect(test("-f", resolve(kosher.tmp,".rcfile"))).not.to.be.ok

          kosher.instance.read().should.be.Object

        it 'should be able to read file contents', () ->

          kosher.instance.value =

            "hello": "world"

          kosher.instance.save()

          kosher.alias 'instance', new kosher.fixture.A

            rcfile: resolve kosher.tmp, ".rcfile"

          kosher.instance.get().should.eql "hello": "world"
