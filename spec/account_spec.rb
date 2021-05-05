require 'account.rb'

describe Account do
    context 'balance' do
        it 'starts as zero' do
            expect(subject.balance).to eq(0)
        end

        context 'is changed when' do
            it 'user makes a deposit' do
                subject.deposit(100)
                expect(subject.balance).to eq(100)
            end

            it 'user makes a withdrawal' do
                subject.deposit(100)
                subject.withdraw(50)
                expect(subject.balance).to eq(50)
            end
        end
    end

    context 'history' do
        context 'has dates when' do
            it 'user makes a deposit' do
                date = Time.new
                subject.deposit(100)
                expect(subject.history).to include(:date => date.strftime("%d/%m/%Y"), :credit => '%.2f' % (100), :balance => '%.2f' % (100))
            end

            it 'user makes a withdrawal' do
                date = Time.new
                subject.deposit(100)
                subject.withdraw(50)
                expect(subject.history).to include(:date => date.strftime("%d/%m/%Y"), :debit => '%.2f' % (50), :balance => '%.2f' % (50))
            end
        end
    end

    context 'statement' do
        it 'prints date and amount credited' do
            date = Time.new
            subject.deposit(100)
            expect { subject.statement }.to output("date || credit || debit || balance\n#{date.strftime("%d/%m/%Y")} || 100.00 ||  || 100.00\n").to_stdout
        end

        it 'prints date and amount debited' do
            date = Time.new
            subject.deposit(100)
            subject.withdraw(50)
            expect { subject.statement }.to output("date || credit || debit || balance\n#{date.strftime("%d/%m/%Y")} || 100.00 ||  || 100.00\n#{date.strftime("%d/%m/%Y")} ||  || 50.00 || 50.00\n").to_stdout
        end
    end
end